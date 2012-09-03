From: swarren@nvidia.com (Stephen Warren)
Date: Mon, 03 Sep 2012 08:33:53 -0600
Subject: [PATCH 3/3] i2c: nomadik: Add Device Tree support to the Nomadik
 I2C driver
In-Reply-To: <CACRpkdZ5VFhrbONy=0K5MFh4e6BDFckq0yqzjQ2QkW9MgwKqBg@mail.gmail.com>
References: <1345734087-21803-1-git-send-email-lee.jones@linaro.org>
 <1345734087-21803-3-git-send-email-lee.jones@linaro.org>
 <20120831112258.GA2624@pengutronix.de> <20120831122323.GC5962@gmail.com>
 <CACRpkdZ=C1EV4WO2b=1YLHPNhsDsQdq7Kfnpzm8i7uGRtVjJuQ@mail.gmail.com>
 <20120903094448.GB11780@pengutronix.de> <20120903100656.GC5782@gmail.com>
 <CACRpkdb8owKBxawAv4LVVYx5kUgZ9cUSiQ=BV0f3Pf3bHtknuQ@mail.gmail.com>
 <CAF2Aj3j25w1Nn9O6hV+=i-j1ts_p_Ucswk_M7r04S7i5BzPkHg@mail.gmail.com>
 <CACRpkdZ5VFhrbONy=0K5MFh4e6BDFckq0yqzjQ2QkW9MgwKqBg@mail.gmail.com>
Message-ID: <5044BFD1.10708@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/03/2012 05:58 AM, Linus Walleij wrote:
> On Mon, Sep 3, 2012 at 1:32 PM, Lee Jones <lee.jones@linaro.org> wrote:
> 
>> No, this is wrong. Platform data should not override DT.
>>
>> If DT is enabled and passed, it should have highest priority.

No, that's wrong. If platform data is specified, it overrides DT, so
that if the DT needs any fixup, it can be provided using platform data.
