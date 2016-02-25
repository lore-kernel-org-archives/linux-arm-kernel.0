From: ynorov@caviumnetworks.com (Yury Norov)
Date: Thu, 25 Feb 2016 23:27:26 +0300
Subject: [PATCH 4/5] all: s390: move compat_wrappers.c from
 arch/s390/kernel to kernel/
In-Reply-To: <1456338854-14901-5-git-send-email-ynorov@caviumnetworks.com>
References: <1456338854-14901-1-git-send-email-ynorov@caviumnetworks.com>
 <1456338854-14901-5-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <20160225202726.GC16123@yury-N73SV>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 24, 2016 at 09:34:13PM +0300, Yury Norov wrote:

[...]

> +COMPAT_SYSCALL_WRAP3(bpf, int, cmd, union bpf_attr *, attr, unsigned int, size);
> +COMPAT_SYSCALL_WRAP3(s390_pci_mmio_write, const unsigned long, mmio_addr, const void __user *, user_buffer, const size_t, length);
> +COMPAT_SYSCALL_WRAP3(s390_pci_mmio_read, const unsigned long, mmio_addr, void __user *, user_buffer, const size_t, length);

Oops... This one should stay in arch/s390, as it was in previous
version.

> 2.5.0
