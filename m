From: tony@atomide.com (Tony Lindgren)
Date: Wed, 7 Mar 2012 09:21:16 -0800
Subject: [PATCH v3] ARM: OMAP2+: gpmc-smsc911x: add required smsc911x
 regulators
In-Reply-To: <CA+Bv8XaJqL1L8F-n6skY7dHn1XAdDLRKaRjw0deLeoQ5Ao0Fhg@mail.gmail.com>
References: <1330006564-13290-1-git-send-email-mporter@ti.com>
 <87wr74gis6.fsf@ti.com>
 <20120301204553.GA21841@legolas.emea.dhcp.ti.com>
 <87pqcqnc7u.fsf@ti.com>
 <CA+Bv8XaJqL1L8F-n6skY7dHn1XAdDLRKaRjw0deLeoQ5Ao0Fhg@mail.gmail.com>
Message-ID: <20120307172116.GF12083@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russ Dill <Russ.Dill@ti.com> [120307 07:28]:
> On Mon, Mar 5, 2012 at 12:18 PM, Kevin Hilman <khilman@ti.com> wrote:
> >
> > In either case $SUBJECT patch is already in Tony's fixes queue, so if it
> > is going be merged, then my fix above is needed also to not break
> > Overo and any other platform that has more than one smsc911x instance.
> >
> > Kevin
> 
> 
> Have you tested this fix? The only regulator consumer supply would be:
> 
> static struct regulator_consumer_supply gpmc_smsc911x_supply[] = {
>         REGULATOR_SUPPLY("vddvario", "smsc911x.0"),
>         REGULATOR_SUPPLY("vdd33a", "smsc911x.0"),
> };
> 
> I don't think the second smsc911x on the Overo, "smsc911x.1", would
> find it due to the dev_id.

Hmm yeah sounds like there's some further changes needed. Dropping
the second version from fixes until we have somebody reply with
tested-by using two smsc911x instances.

Regards,

Tony
