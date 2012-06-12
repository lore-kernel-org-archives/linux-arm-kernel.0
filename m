From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Tue, 12 Jun 2012 09:24:44 +0200
Subject: [PATCH v2 05/10] ARM: tegra: Rewrite PCIe support as a driver
In-Reply-To: <20120612064124.GF4040@avionic-0098.adnet.avionic-design.de>
References: <1339427118-32263-1-git-send-email-thierry.reding@avionic-design.de>
 <1339427118-32263-6-git-send-email-thierry.reding@avionic-design.de>
 <4FD65E98.4070200@wwwdotorg.org>
 <20120612064124.GF4040@avionic-0098.adnet.avionic-design.de>
Message-ID: <20120612072444.GA8577@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Thierry Reding wrote:
> AFAICT the even partitioning of the non-prefetchable and prefetchable
> memory regions is arbitrary and it could potentially be useful to make
> it configurable via the DT.

So it turns out that this isn't true. But apart from the comments in the
driver I couldn't find any reference to how the prefetch and non-prefetch
ranges are partitioned. Judging by the code for Tegra2 this is evenly
partitioned among ports 0 and 1 but it would be interesting to know this is
done on Tegra3. Is there any way you can find out?

It'd also be nice if some better documentation for the PCIe controller could
be made available. The Tegra2 TRM doesn't contain any of the AFI or PADS
registers and while the Tegra3 TRM documents more registers, their offsets
are completely missing.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120612/0a21f4a7/attachment.sig>
