From: chenbaozi@kylinos.com.cn (Chen Baozi)
Date: Tue, 27 Jan 2015 19:15:16 +0800
Subject: [PATCH] irqchip: GICv3: ITS: Allocate enough memory for the full
 range of DeviceID
In-Reply-To: <1422327961-19733-1-git-send-email-baozich@gmail.com>
References: <1422327961-19733-1-git-send-email-baozich@gmail.com>
Message-ID: <15CDAC06-1E2B-4545-93E8-CBB4B47E2707@kylinos.com.cn>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Jan 27, 2015, at 11:06, Chen Baozi <baozich@gmail.com> wrote:
> 
> The ITS table allocator is only allocating a single page per table.
> This works fine for most things, but leads to silent lack of
> interrupt delivery if we end-up with a device that has an ID that is
> out of the range defined by a single page of memory. Even worse, depending
> on the page size, behaviour changes, which is not a very good experience.
> 
> A solution is actually to allocate memory for the full range of ID that
> the ITS supports. A massive waste memory wise, but at least a safe bet.
> 
> This patch has been tested on the Phytium SoC.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Failed to clarify that Marc is the author of this patch.

Sorry for the mistake.

Cheers,

Baozi.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 842 bytes
Desc: Message signed with OpenPGP using GPGMail
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150127/03bf04e0/attachment.sig>
