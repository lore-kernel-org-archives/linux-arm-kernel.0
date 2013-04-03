From: mturquette@linaro.org (Mike Turquette)
Date: Tue, 02 Apr 2013 17:34:50 -0700
Subject: RFC v2: Zynq Clock Controller
In-Reply-To: <9b6821a5-8275-427e-a5aa-1bfd8e800d1b@TX2EHSMHS027.ehs.local>
References: <27dae808-1d3a-4001-8eb2-b0a6e2a34b8f@AM1EHSMHS013.ehs.local>
 <515093B4.2090701@wwwdotorg.org>
 <8fd7278d-37c5-48ff-8d06-edc64d532a96@VA3EHSMHS037.ehs.local>
 <5150DEB6.7070208@wwwdotorg.org>
 <b810d127-dad8-447c-bf88-8ac715debbff@CO9EHSMHS026.ehs.local>
 <20130327021844.4014.43809@quantum>
 <9b6821a5-8275-427e-a5aa-1bfd8e800d1b@TX2EHSMHS027.ehs.local>
Message-ID: <20130403003450.8177.2879@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting S?ren Brinkmann (2013-03-29 15:36:18)
> On Tue, Mar 26, 2013 at 07:18:44PM -0700, Mike Turquette wrote:
> > As long as a key exists to link two clocks together then registration
> > order shouldn't matter.  Originally this key was an immutable clk name
> > string.
> > 
> > If clock parents are specified in DT then that should also suffice, in
> > place of doing string comparisons.
> > 
> > If no key to pair up clocks exists then yes we will have to rely purely
> > on the struct clk *opaque_cookie and register clocks in order.
> Okay, so I guess, the fundamental mechanisms should be in place. What is
> needed, is changing the key from being the clk name to something else.
> And preferably this something else is made up of something available
> through DT, so a child can reference its parent w/o the parent to be
> probed first. E.g. the provider's node name + the index of the clock
> output?

Right, order shouldn't matter in the sense that registering a child
before a parent should not constitute an absolute failure from the clock
framework point of view.

Folks using DT today still rely on the parent string name to link things
up.  Grep around for usage of of_clk_get_parent_name to see how several
platforms use that during registration.

> You mentioned, something like this was supposed to happen anyway, right?
> Do you already have something specific in mind/are working on a
> solution?
> 

I'm not looking at it currently.  If no one else gets around to it then
eventually I will.  It would be nice to not have to use
of_clk_get_parent_name and instead have a better way to establish
parent-child relationships at clock registration-time for DT clocks.

Regards,
Mike

>         S?ren
