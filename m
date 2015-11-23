From: JBeulich@suse.com (Jan Beulich)
Date: Mon, 23 Nov 2015 08:46:01 -0700
Subject: [PATCH v3 03/62] acpi/pmstat: Build pmstat for x86 only
In-Reply-To: <1447753261-7552-4-git-send-email-shannon.zhao@linaro.org>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
 <1447753261-7552-4-git-send-email-shannon.zhao@linaro.org>
Message-ID: <565342C902000078000B7F66@prv-mh.provo.novell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>> On 17.11.15 at 10:40, <shannon.zhao@linaro.org> wrote:
> --- a/xen/common/sysctl.c
> +++ b/xen/common/sysctl.c
> @@ -171,7 +171,7 @@ long do_sysctl(XEN_GUEST_HANDLE_PARAM(xen_sysctl_t) u_sysctl)
>          op->u.availheap.avail_bytes <<= PAGE_SHIFT;
>          break;
>  
> -#ifdef HAS_ACPI
> +#ifdef HAS_CPUFREQ

You should combine the two instead of replacing one with the other.

Jan
