From: pali.rohar@gmail.com (Pali =?utf-8?q?Roh=C3=A1r?=)
Date: Wed, 18 Jun 2014 21:09:58 +0200
Subject: [PATCH] ARM: /proc/cpuinfo: Use DT machine name when possible
In-Reply-To: <20140618190108.GI32514@n2100.arm.linux.org.uk>
References: <1403110464-29646-1-git-send-email-pali.rohar@gmail.com>
 <20140618190108.GI32514@n2100.arm.linux.org.uk>
Message-ID: <201406182109.59059@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 18 June 2014 21:01:09 Russell King - ARM Linux 
wrote:
> On Wed, Jun 18, 2014 at 06:54:24PM +0200, Pali Roh?r wrote:
> > Machine name from board description is some generic name on
> > DT kernel. DT provides machine name property which is
> > specific for board, so use it instead generic one when
> > possible.
> 
> http://archive.arm.linux.org.uk/lurker/message/20130726.132850
> .53d47576.en.html
> 
> "If userspace wants to get at the DT information about a
> platform, we already have ways that can happen already - we
> export the DT stuff so that kexec's tools can get at it."

Userspace application does not know that kernel using DT. And 
also it does not want to get DT information. Only board/machine 
name. So existing applications stop working after migration to 
DT. And because legacy board boot code (without DT) is going to 
be removed for ARM in near future this will permanently break 
existing applications.

And sometimes it is even not possible to fix userspace 
application if is closed source - binary only.

-- 
Pali Roh?r
pali.rohar at gmail.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140618/5d34ccda/attachment.sig>
