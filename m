From: jkrzyszt@tis.icnet.pl (Janusz Krzysztofik)
Date: Sat, 10 Dec 2011 13:04:29 +0100
Subject: [PATCH 5/5 v2] ARM: OMAP1: recalculate loops per jiffy after
 dpll1 reprogram
In-Reply-To: <20111210002503.GA6018@n2100.arm.linux.org.uk>
References: <1322364751-29980-6-git-send-email-jkrzyszt@tis.icnet.pl>
 <201112091100.01690.jkrzyszt@tis.icnet.pl>
 <20111210002503.GA6018@n2100.arm.linux.org.uk>
Message-ID: <201112101304.30135.jkrzyszt@tis.icnet.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 10 of December 2011 at 01:25:03, Russell King - ARM Linux wrote:
> On Fri, Dec 09, 2011 at 11:00:01AM +0100, Janusz Krzysztofik wrote:
> > 
> > Those were BogoMIPS, ...
> 
> I realise that.  But which is which - is 70.40 from recalibrate_delay
> or is it 74.54?  Your message is too vague to be able to interpret your
> results because it's impossible to work out what figure refers to which
> method.

Yes, I realised what you had actually asked about after re-reading your 
answer, which I unfortunately did after I had already replied, sorry.

> > ... Then, in case of a machine always booting at, let's say, 12 and
> > then reprogrammed to 150 MHz, we actually scale up that less then the
> > theoretical number, with a side effect of scaling up its error as well.
> > Perhaps in this case, when the machine is going to run at that target
> > rate until rebooted, we should rather decide to recalibrate to keep
> > that error proportionally small compared to the target loops per
> > jiffy value ...
> 
> It really doesn't matter - udelay() etc is not designed to be mega
> accurate but good enough... 

Great, that's the answer to my initial question: loops per jiffy 
inaccuracy of 6% shouldn't matter.

Thanks,
Janusz
