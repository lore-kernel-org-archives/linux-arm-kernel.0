From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Thu, 16 Feb 2012 12:28:38 +0100
Subject: remoteproc: Load coprocessor code to the specific main memory
 location
In-Reply-To: <4F3CC899.4070302@monstr.eu>
References: <4F1EE861.4030405@monstr.eu>
 <CAK=Wgba5kT8AwLtuHyosucYnWf-EA+xpE1kzmssfhSC7ZXQA=g@mail.gmail.com>
 <4F1FF870.3000105@monstr.eu>
 <CAK=WgbZwaxMPsMiNcq5yFvBLrcODqGgDT6b=mmQ91JBVtTEyXA@mail.gmail.com>
 <4F200F64.9060203@monstr.eu>
 <CAK=WgbZDADRf1OF=uWbbsF+t2dx36tqj=kRftn5nd4RA7DtEnA@mail.gmail.com>
 <4F212E9E.9060807@monstr.eu>
 <CAK=WgbYMBDp3Qm8TErNrnDwn2ZTFt62+OuyyQvVE-jrnNsL6kg@mail.gmail.com>
 <4F391C1D.9020402@monstr.eu>
 <CAK=WgbYn6hrS4YLEdfp=0jSEfEwy-HkJmt5S06_j6gZFf0UTmQ@mail.gmail.com>
 <4F3BA962.9040109@monstr.eu> <4F3BC30A.4030301@monstr.eu>
 <4F3CC899.4070302@monstr.eu>
Message-ID: <CAK=WgbaRF-L7M3VMZQdqFLUFOJuwFVkBH1hUNuJ51kSrzkaVjA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 16, 2012 at 10:12 AM, Michal Simek <monstr@monstr.eu> wrote:
> I should be more specific. Can you point me to remoteproc code which publish
> remote service based on them Linux rpmsg driver will be probed? It is rtos
> part of code.
> In your ELCE presentation is called rpmsg-client-sample service.

Sorry for the late response (I'm in ELC).

Yes, use the client sample (which is part of the submitted patch set)
and not the omx/server samples (which are public, but were never
submitted nor cleaned up).

The channels are created dynamically: the rpmsg bus designates address
53 for a name service, which listens to channel creation/removal
announcements coming from the remote processor. Take a look in
virtio_rpmsg_bus.c and you'll immediately see it.

Hope this helps,
Ohad.
