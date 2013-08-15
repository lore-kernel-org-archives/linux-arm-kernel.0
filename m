From: zonque@gmail.com (Daniel Mack)
Date: Thu, 15 Aug 2013 15:43:14 +0200
Subject: [PATCH 2/5] ASoC: pxa: pxa-ssp: add DT bindings
In-Reply-To: <20130815133925.GA30073@sirena.org.uk>
References: <1376296961-20564-1-git-send-email-zonque@gmail.com>
 <1376296961-20564-3-git-send-email-zonque@gmail.com>
 <20130815103358.GY2401@sirena.org.uk> <520CB2B3.9050804@gmail.com>
 <20130815133925.GA30073@sirena.org.uk>
Message-ID: <520CDAF2.7010101@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15.08.2013 15:39, Mark Brown wrote:
> On Thu, Aug 15, 2013 at 12:51:31PM +0200, Daniel Mack wrote:
> 
>> Hmm, and you don't like the approach either of having upstream ports and
>> assign users to it via phandles?
> 
> I don't know what that means, sorry.

Well, we have the 'real' devices registered in DT like this:

        ssp0: ssp at 41000000 {
                compatible = "mrvl,pxa3xx-ssp";
                reg = <0x41000000 0x40>;
                interrupts = <24>;
                clock-names = "pxa27x-ssp.0";
                dmas = <&dma 13
                        &dma 14>;
                dma-names = "rx", "tx";
        };

And users, in that case, a ssp DAI, just reference a port like so:

        ssp_dai0: ssp_dai at 0 {
                compatible = "mrvl,pxa-ssp-dai";
                port = <&ssp0>;
        };

Is that something we can live with?


>> Also note that the last patch in that series ("ASoC: pxa: add DT
>> bindings for pxa2xx-pcm") can be omitted, as Lars pointed out. I'll have
>> to care for a proper solution at some point.
> 
> I applied it since we were already adding a dummy device for the DAI.  I
> can revert it if this work without that.

I'll send a cleanup patch once I have a better solution.



Daniel
