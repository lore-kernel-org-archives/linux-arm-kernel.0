From: olof@lixom.net (Olof Johansson)
Date: Mon, 22 Aug 2011 15:56:55 -0700
Subject: [RFC PATCH v2 00/13] arm/tegra: Initialize GPIO & pinmux from DT
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF04B24A3687@HQMAIL01.nvidia.com>
References: <1313440100-17131-1-git-send-email-swarren@nvidia.com>
	<74CDBE0F657A3D45AFBB94109FB122FF04B24A3687@HQMAIL01.nvidia.com>
Message-ID: <CAOesGMhGb1-sOaBU4oaa_8-1triS01tOmseJqYyCm849feLhXg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 22, 2011 at 12:56 PM, Stephen Warren <swarren@nvidia.com> wrote:
> Stephen Warren wrote at Monday, August 15, 2011 2:28 PM:
>> ...
>> This patch modifies Tegra's device tree support to remove the dependency
>> on harmony_pinmux_init(), thus making it completely board-independent.
>
> I had the good fortune of meeting Grant at LinuxCon last week and talked
> through this patchset a little (thanks!)
>
> The message I got from Grant was that the patches are basically OK. He
> did have a couple of concerns:
>
> * Does this cause the compiled DTB to blow up in size.
>
> The DTB goes from ~3-4K to ~8-9K with these patches added. While that
> is a large % increase, Grant said that as an absolute value, that size
> shouldn't be an issue.

Agreed, especially if compared with the size of the current in-kernel table.

> * There's lots of repetition in the .dts representation; can this be improved?
>
[...]
> meaningless-name { // typically would just use the pin name
> ? ?pins = "ld0", "ld1", "ld2", ...;
> ? ?nvidia,function = "displaya";
> ? ?nvidia,pull-down;
> };

That sounds quite close to what I was thinking about earlier (with
s/meaningless-name/displaya/ in the above example).

> * We also briefly discussed that dtc could be modified to support symbolic
> constants, so we could use named integers for the function names (perhaps
> pin names too). I'll look into how easy it is to modify dtc for this.

That'd be useful, I think -- there's still the whole issue of the same
pin function being at different mux locations on different pin groups,
so an integer representation might not work.

> I'll look into implementing these enhancements, and others discussed in
> this email thread, and repost.

Cool.


-Olof
