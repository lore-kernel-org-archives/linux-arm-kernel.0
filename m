From: dianders@chromium.org (Doug Anderson)
Date: Wed, 30 May 2018 09:12:25 -0700
Subject: [PATCH v4 1/2] regulator: dt-bindings: add QCOM RPMh regulator
 bindings
In-Reply-To: <20180530155044.GR6920@sirena.org.uk>
References: <cover.1527040878.git.collinsd@codeaurora.org>
 <6d03576cf90f06afb1194301cb41fc31704def1d.1527040878.git.collinsd@codeaurora.org>
 <CAD=FV=VH0bTxPOmRr+jUyV0cGNQHLcwQTV9L-t0bxZOqD8FnHA@mail.gmail.com>
 <20180530103720.GH6920@sirena.org.uk>
 <CAD=FV=WTTKXwPchuWRh-RNTc8=X8Xo28oTqk=3wW4+SiTHhxuA@mail.gmail.com>
 <20180530155044.GR6920@sirena.org.uk>
Message-ID: <CAD=FV=WVUmvPPd5BxXv9Sa_2CRPrrjQvYFyqroY-3fRr4f0Bzg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, May 30, 2018 at 8:50 AM, Mark Brown <broonie@kernel.org> wrote:
> On Wed, May 30, 2018 at 07:54:47AM -0700, Doug Anderson wrote:
>> On Wed, May 30, 2018 at 3:37 AM, Mark Brown <broonie@kernel.org> wrote:
>
>> > I'm confused as to why we are specifying the maximum current the device
>> > can deliver in a given mode in the DT - surely that's a fixed property
>> > of the hardware?
>
>> Said another way: you're saying that you'd expect the "max-microamps"
>> table to have one fewer element than the listed modes?  So in the
>> above example you'd have:
>
> No, I'm saying that I don't know why that property exists at all.  This
> sounds like it's intended to be the amount of current the regulator can
> deliver in each mode which is normally a design property of the silicon.

Ah, got it.  So the whole point here is to be able to implement either
the function "set_load" or the function "get_optimum_mode".  We need
some sort of table to convert from current to mode.  That's what this
table does.

My argument to David was that since set_load / get_optimum_mode were
features of the regulator core these should actually be standard
properties and not Qualcomm-specific ones.

-Doug
