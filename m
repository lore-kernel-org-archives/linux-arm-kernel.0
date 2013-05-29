From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 29 May 2013 13:55:26 +0530
Subject: [linux-pm] ARM hibernation / suspend-to-disk
In-Reply-To: <20130529081005.GA25561@hal>
References: <20130529081005.GA25561@hal>
Message-ID: <CAKohpomgf4QZ=71JNYztBZTjcqqZw5MK69dR==Thay7yz5q1jg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29 May 2013 13:40, Jan Glauber <jan.glauber@gmail.com> wrote:
> what's the status of suspend-to-disk on ARM? The most recent discussion I
> found is:
> http://lists.linuxfoundation.org/pipermail/linux-pm/2012-November/034997.html
>
> with no replies at all. Is anyone still working on that? Anyone got it running?
>
> I tried the patch above (on top of LTS 3.4) and got stuck forever, the last
> thing on the console was:
>
> root at omap5:/sys/power# echo disk > state
> [ 2015.641540] PM: Syncing filesystems ... done.
> [ 2015.666870] PM: Preallocating image memory... done (allocated 16957 pages)
> [ 2016.062011] PM: Allocated 67828 kbytes in 0.38 seconds (178.49 MB/s)
>
> Any hint how to debug that?

I know it is still broken and I had discussion with Kevin in past
regarding that. See below.

On 13 March 2013 22:57, Kevin Hilman <khilman@linaro.org> wrote:
> Viresh Kumar <viresh.kumar@linaro.org> writes:
>
>> Hi Guys,
>>
>> As discussed during connect about "HIBERNATION support for ARM platforms",
>> this is my last mail on this, almost a year back, where i tried my best to get
>> relevant answer from Amit.
>>
>> Probably he missed all my mails then, but this might be a good starting point
>> for this discussion as i did some testing on hibernation earlier.
>>
>> https://lkml.org/lkml/2012/2/6/8
>
> I think the reason that ARM sub-arches are not setting things up is
> because ARM has never supported hibernation in mainline.
>
> The most recent patch to add basic support[1] references the various
> discussions on what is needed and still missing.
>
> Kevin
>
> [1] http://marc.info/?l=linux-omap&m=135292458209355&w=2
