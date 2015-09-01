From: ian.campbell@citrix.com (Ian Campbell)
Date: Tue, 1 Sep 2015 09:44:23 +0100
Subject: [PATCH v5] dtb: Create a common home for cross-architecture
 dtsi files.
In-Reply-To: <CAOesGMhj50wg5WyByC7kHp3joo-ahfYWWDLLudp=kyKMpxauhg@mail.gmail.com>
References: <1438618000-1091-1-git-send-email-ian.campbell@citrix.com>
 <1439287646.9747.212.camel@citrix.com>
 <CAL_JsqKv2aOEM-U7JNZnaHomA6HFBSFhSLZ-zhp7c20s6gQBaQ@mail.gmail.com>
 <CAOesGMj46mvbdya1OQnZzL8VrxVwxAV3KoZZRtk3c0CTVx7d5w@mail.gmail.com>
 <CAL_Jsq+tUmRfvKE6vf+za6TsG_fhMWn5M2DDDLcCfkDt=KJGVg@mail.gmail.com>
 <CAOesGMigmaEviCDBAncomkq+uowr18B5FTOmOyBHsNz4p6F6Dw@mail.gmail.com>
 <CAL_JsqKu6B1Q1q38GFSkdAT+Gxg3=87uk8ZOGPH96Eni0cer_g@mail.gmail.com>
 <CAOesGMhj50wg5WyByC7kHp3joo-ahfYWWDLLudp=kyKMpxauhg@mail.gmail.com>
Message-ID: <1441097063.27618.3.camel@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2015-08-24 at 15:22 -0700, Olof Johansson wrote:
> Hi,
> 
> On Mon, Aug 24, 2015 at 1:58 PM, Rob Herring <robherring2@gmail.com> 
> wrote:
> > On Sun, Aug 23, 2015 at 6:52 PM, Olof Johansson <olof@lixom.net> wrote:
> > > On Sun, Aug 23, 2015 at 4:42 PM, Rob Herring <robherring2@gmail.com> 
> > > wrote:
> > > > On Sun, Aug 23, 2015 at 6:13 PM, Olof Johansson <olof@lixom.net> 
> > > > wrote:
> > > > > 
> > > Right now it's not possible to do even per-arch "all-dtbs" since only
> > > the currently configured platforms will get their dtbs compiled.
> > 
> > I know. It's been on my todo list for a while. Having that per arch at
> > least would be an improvement. Having it arch independent would mean I
> > don't even need a cross-compiler (probably).
> 
> Yeah, seems like something that should work quite well in the scope of
> Ian's tree if nothing else.

In the split tree "make all -k" will already build every dtb (and always
has done), in fact this is how I discovered the breakage which I'm trying
to address with this patch since the daily cronjob which does the
conversion runs this.

> Something like lib/ seems more appropriate. Or drivers/..., but I
> suspect that could cause further confusion on the expected separation
> of binding/hardware description and the consuming drivers.

I'm quite happy to rework the patch with whatever path is settled upon.

Or if someone has an alternative suggestion for how to fix the build in the
split devicetree git tree I'm happy to give that a go too.

> > > > We could also see sharing between PPC and ARM on FSL networking 
> > > > parts,
> > > > but I've not heard if they actually have that problem.
> > > 
> > > Yeah, there could potentially be some sharing between MIPS and
> > > ARM{,64} too, but I don't know if we'll actually see it done.
> > 
> > Yep, hard to say.
> > 
> > Rob
