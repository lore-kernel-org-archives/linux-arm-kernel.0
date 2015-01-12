From: oleg@redhat.com (Oleg Nesterov)
Date: Mon, 12 Jan 2015 15:38:00 +0100
Subject: [RFC 8/8] ARM64: Add uprobe support
In-Reply-To: <54B36D8E.4030001@redhat.com>
References: <cover.1420038188.git.panand@redhat.com>
 <0694af6935f9c6873ef8d25ad51630a40a74a116.1420038188.git.panand@redhat.com>
 <20150109175936.GB13161@redhat.com> <54B355FA.60702@redhat.com>
 <54B36D8E.4030001@redhat.com>
Message-ID: <20150112143800.GC25914@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/12, Pratyush Anand wrote:
>
> Hi Oleg,
>
> How can I generate a scenario to test:
>
> a) arch_uprobe_xol_was_trapped
> b) arch_uprobe_abort_xol

For example, you can probe something like

	*(int *)NULL = 0;

See also the x86 test-case in https://lkml.org/lkml/2011/10/21/148
and the whole thread.

Oleg.
