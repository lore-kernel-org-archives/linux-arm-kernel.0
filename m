From: omar.luna@linaro.org (Omar Ramirez Luna)
Date: Mon, 10 Sep 2012 12:14:11 -0500
Subject: [PATCH 2/2] ARM: OMAP: hwmod: revise deassert sequence
In-Reply-To: <5048BD7A.7060408@ti.com>
References: <1345614150-25723-1-git-send-email-omar.luna@linaro.org>
 <1345614150-25723-3-git-send-email-omar.luna@linaro.org>
 <5048BD7A.7060408@ti.com>
Message-ID: <CALLhW=4SnyXRwHWToAy6Lxyxr5P7GAMUZ5e=zGhr30cE_sEU6Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Benoit,

On 6 September 2012 10:12, Benoit Cousson <b-cousson@ti.com> wrote:
> The sequence is good, I'm just a little bit concern about the
> duplication of code compared to _enable sequence.
>
> That being said, this is the consequence of removing the hardreset
> sequence outside of the main _enable/_shutdown sequence.
>
> So I'm not sure I have any better way of doing that :-(

Indeed, it should be exactly the same as putting back the reset
sequence into _enable/_shutdown, so with these patches I was expecting
we could gather the hard reset users and see if they needed anything
else beyond these functions, if not, perhaps just put back the reset
code into _enable/_shutdown paths.

Thanks,

Omar
