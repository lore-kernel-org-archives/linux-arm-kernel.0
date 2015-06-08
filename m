From: rnayak@codeaurora.org (Rajendra Nayak)
Date: Mon, 08 Jun 2015 09:59:27 +0530
Subject: [RFC 0/7] qcom: Add support for tsens driver
In-Reply-To: <7hvbf1y974.fsf@deeprootsystems.com>
References: <1429796773-7151-1-git-send-email-rnayak@codeaurora.org>
 <7hvbf1y974.fsf@deeprootsystems.com>
Message-ID: <55751A27.6030306@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,

> Curious how are you testing this?  with which thermal governor?

I have been mostly testing this with step wise on the db410c target
board.

>
> I'm experimenting with the new thermal power_allocator governor
> currently in linux-next, and was hoping to use this to test it, but I'm
> noticing it doesn't work with the power_allocator governor.
>
> The first thing is that the power_allator goveror expects each thermal
> zone to have a sustainable-power property in the DT, which this series
> doesn't provide.  Hacking some dummy values in there to see what happens
> next, I then hit the "thermal zone cpu-thermal0 has wrong trip setup for
> power allocator" error from the power_allocator driver.

Right, the RFC I posted wasn't tested with IPA and hence does not have
some of the additional properties in DT which IPA expects.
The wrong trip setup error that you are seeing is because IPA expects
2 passive trip points, a "switch on" trip point and a "desired
temperature" trip point and the dts I posted with the RFC had
just one passive trip point.

I am in the process of testing this with IPA myself (on db410c mainly,
but will also test on db8074 and IFC6410/6540 as well) and will repost
in a few days with updated dts entries and a few other minor fixes
to the driver itself. Let me know what target board you are
interested to get this working on and I will make sure I test on it
before I repost.

regards,
Rajendra
