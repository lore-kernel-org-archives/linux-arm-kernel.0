From: ben-linux@fluff.org (Ben Dooks)
Date: Thu, 6 May 2010 06:53:05 +0100
Subject: [PATCH v2.6.34-rc2] s3c: Fix CONFIG_MTD_NAND_S3C2410_CLKSTOP
In-Reply-To: <o2wcabda6421005040013rc335f723qc0f2f6018f0ba578@mail.gmail.com>
References: <1269937323-7541-1-git-send-email-chripell@fsfe.org>
	<20100504065701.GB26401@trinity.fluff.org>
	<o2wcabda6421005040013rc335f723qc0f2f6018f0ba578@mail.gmail.com>
Message-ID: <20100506055305.GN26401@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 04, 2010 at 09:13:41AM +0200, christian pellegrin wrote:
> On Tue, May 4, 2010 at 8:57 AM, Ben Dooks <ben-linux@fluff.org> wrote:
> >
> > please let me know why you feel the need to use test_and_set_bit on
> > a variable that is single use.
> >
> 
> As I mentioned in the description the select function is not called in
> a balanced way by upper layers, so there is a need to count it in the
> driver (otherwise you end by calling clk_disable too many times if I
> remember well). Perhaps the atomic operations are not needed but I'm
> not sure about this so I preferred to take the cautionary approach (I
> haven't studied if calls to select are serialized in the upper MTD
> layer or even the block layer). Feel free to use a simple integer, but
> I confirm that something like this patch is needed in 2.6.33 and
> 2.6.34 if you want clock stopping enabled.

I don't belive that atomic ops are needed, IIRC the mtd layer should
sort that out. As such test_and_set_bit is hardly a count?
 
> Thanks,
> 
> -- 
> Christian Pellegrin, see http://www.evolware.org/chri/
> "Real Programmers don't play tennis, or any other sport which requires
> you to change clothes. Mountain climbing is OK, and Real Programmers
> wear their climbing boots to work in case a mountain should suddenly
> spring up in the middle of the computer room."
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
