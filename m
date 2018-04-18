From: sven.eckelmann@openmesh.com (Sven Eckelmann)
Date: Wed, 18 Apr 2018 09:07:27 +0200
Subject: [v5,05/13] ARM: dts: ipq4019: Add ipq4019-ap.dk04.dtsi
In-Reply-To: <2641190.FRMBLJWkCS@bentobox>
References: <1521800336-19266-6-git-send-email-sricharan@codeaurora.org>
 <2641190.FRMBLJWkCS@bentobox>
Message-ID: <2284833.pBtR1QS54F@bentobox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mittwoch, 18. April 2018 08:59:46 CEST Sven Eckelmann wrote:
[...]
> I would not know how to disable QSEE on these boards and thus would assume 
> that it should be part of this dtsi.


Just did some reviews of the reserved-memory regions in other QCA devices and 
it looks like this tz and smem are often directly added to the SoC dtsi. So I 
will prepare a similar change for qcom-ipq4019.dtsi and this would then solve 
it for AP-DK01/04/07 and no changes in the board-family specific dtsi would be 
necessary.

But maybe someone has an objection because tz and smem can actually be 
disabled in a sane way on these SoCs and thus it would be better to have these 
regions in the board specific dts(i) files. We will see...

Kind regards,
	Sven
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180418/670d3b60/attachment.sig>
