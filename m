From: andrew@fubar.geek.nz (Andrew Turner)
Date: Thu, 10 Sep 2015 12:32:51 +0100
Subject: [PATCH] efi/libstub/fdt: Standardize the names of EFI stub
 parameters
In-Reply-To: <1441874516-11364-1-git-send-email-zhaoshenglong@huawei.com>
References: <1441874516-11364-1-git-send-email-zhaoshenglong@huawei.com>
Message-ID: <20150910123251.7e0810d1@bender.Home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 10 Sep 2015 16:41:56 +0800
Shannon Zhao <zhaoshenglong@huawei.com> wrote:

> From: Shannon Zhao <shannon.zhao@linaro.org>
> 
> These EFI stub parameters are used to internal communication between
> EFI stub and Linux kernel and EFI stub creates these parameters. But
> for Xen on ARM when booting with UEFI, Xen will create a minimal DT
> providing these parameters for Dom0 and Dom0 is not only Linux
> kernel, but also other OS (such as FreeBSD) which will be used in the
> future. So here we plan to standardize the names by dropping the
> prefix "linux," and make them common to other OS. Also this will not
> break the compatibility since these parameters are used to internal
> communication between EFI stub and kernel.

It is unlikely FreeBSD will use this property when booting ad Xen dom0.
The kernel expects to be passed a data structure to find boot this
information.

My preference would be to have the FreeBSD loader load the xen binary,
the FreeBSD kernel, and set up these data structs before passing
control to Xen, with the information it needs to boot the kernel. My
understanding is this is how it is done on x86.

I can see a few issues with this where, for example, the device tree or
ACPI tables need to be modified, but these should be solvable.

Andrew
