From: broonie@kernel.org (Mark Brown)
Date: Thu, 1 Mar 2018 20:34:13 +0000
Subject: [PATCH v3 01/25] dt-bindings: soc: qcom: Add bindings for APR bus
In-Reply-To: <465a2ca7-9f74-8977-37ea-29fe3944c27c@linaro.org>
References: <20180213165837.1620-1-srinivas.kandagatla@linaro.org>
 <20180213165837.1620-2-srinivas.kandagatla@linaro.org>
 <20180213231244.ama4bwsehzuh5sr7@rob-hp-laptop>
 <ae65a9c8-85a3-5494-f4cc-1038fd8c9bd1@linaro.org>
 <20180218230414.dkd6kb6kd35arcyv@rob-hp-laptop>
 <636d4ac2-3bc2-7290-1645-0451c089cb8a@linaro.org>
 <CAL_JsqK3KFBGqpHRaURSrHew1HhObUvFYxuhND-FOQ4tCUaAHg@mail.gmail.com>
 <465a2ca7-9f74-8977-37ea-29fe3944c27c@linaro.org>
Message-ID: <20180301203413.GN12864@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 22, 2018 at 10:03:42AM +0000, Srinivas Kandagatla wrote:
> On 22/02/18 00:14, Rob Herring wrote:

> > Am I saying a single DT node for this? Yes, perhaps.
> Yes, I will give that a go.
> 
> So we will endup having something like this in DT for one frontend and
> backend dailink:

Let's not start encoding DPCM into DT, DPCM is very much an
implemntation detail of the current stack which we're gradually pushing
towards replacing with something better.  What we want to be doing is
just treating components inside the SoC the same as components in a
CODEC, the routing within a SoC being the same as in a CODEC and
similarly for externally connected devices.

> 		fe at 1 {
>                 	is-fe;
>                         link-name = "MultiMedia1";

In particular having the concept of "front end" in the DT is *very*
implementation specific.  We should just be describing the connections
that exist in the system.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180301/b8f7604e/attachment.sig>
