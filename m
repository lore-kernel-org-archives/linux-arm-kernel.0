From: rnayak@ti.com (Nayak, Rajendra)
Date: Thu, 27 Oct 2011 16:13:08 +0530
Subject: [PATCH v3 1/4] regulator: helper routine to extract
	regulator_init_data
In-Reply-To: <20111027080953.GB18360@opensource.wolfsonmicro.com>
References: <1319702185-16108-1-git-send-email-rnayak@ti.com>
	<1319702185-16108-2-git-send-email-rnayak@ti.com>
	<20111027080953.GB18360@opensource.wolfsonmicro.com>
Message-ID: <CACYZBRG+_mm1O7Qg+ENCcLBX72iEWWyJohD_9EpAaT+Pb54cEA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> If we have min_uV and max_uV we should also set REGULATOR_CHANGE_VOLTAGE
> (and similarly for the currents).
>
> We should also have a way to enable status changes - since there's an
> always_on property (which does make sense) I'd suggest that as a first
> pass we should enable status changes if always_on is not set (these two
> things are a bit redundant in the existing constrints). ?This is
> slightly risky as you can get a situation where new device driver
> support for regulators starts unexpectedly turning off supplies but
> that's always going to be a risk with constraints disassociated from the
> kernel.

okay, here's an updated patch which does that. I also added a binding to
specify a descriptive name to the regulator outputs as you suggested in
the other thread.
