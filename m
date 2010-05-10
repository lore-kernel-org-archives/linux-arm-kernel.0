From: Valdis.Kletnieks@vt.edu (Valdis.Kletnieks at vt.edu)
Date: Mon, 10 May 2010 10:52:08 -0400
Subject: [PATCH] Handle instruction cache maintenance fault properly
In-Reply-To: Your message of "Mon, 10 May 2010 16:34:57 +0300."
	<AANLkTint0f2Ow2FM3jVAqGfPjolHvF-oBTGCmY7Jx7_d@mail.gmail.com>
References: <AANLkTikIbI6hKoYSZlo6QDlyi2Qjxg287i-ilHpz1FF9@mail.gmail.com>
	<20100510131519.GB7796@n2100.arm.linux.org.uk>
	<AANLkTint0f2Ow2FM3jVAqGfPjolHvF-oBTGCmY7Jx7_d@mail.gmail.com>
Message-ID: <7529.1273503128@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 10 May 2010 16:34:57 +0300, "Kirill A. Shutemov" said:

> It looks like cache maintenance fault was introduced in ARMv6.
> 
> So, what is the right way to fix it? Something like:
> 
> #if __LINUX_ARM_ARCH__ < 6
>         { do_bad,               SIGBUS,  0,             "external

This would need to be a runtime test, no?  Or does LINUX_ARM_ARCH not allow
it to run on other arch levels? (i.e. can an ARM kernel boot for v5 and v6?)
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 227 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100510/69f17186/attachment.sig>
