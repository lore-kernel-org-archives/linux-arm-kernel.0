From: anish198519851985@gmail.com (anish singh)
Date: Wed, 27 Feb 2013 17:37:52 +0530
Subject: How to measure the RAM read/write performance
In-Reply-To: <CAL7WMDcM9XommwO+rYJa5doMVXrFv1Vptu-s9cqaWfVXgx-qVg@mail.gmail.com>
References: <CAL7WMDcM9XommwO+rYJa5doMVXrFv1Vptu-s9cqaWfVXgx-qVg@mail.gmail.com>
Message-ID: <CAK7N6vrptC7yOrH=boskNQD27PA-PqT9oPVgWe4Fagk95r4s=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 26, 2013 at 5:01 PM, sandeep kumar
<coolsandyforyou@gmail.com> wrote:
> Hi All
> In performance benchmark tools, When we profile read/write timings mostly,
> those read/writes are done to cache only.
>
> I want to measure my DDR(RAM chip) performance.
> So i want to make sure, every read/write should happen to DDR RAM chip only.
Try below points:
1. I am not sure about snapdragon(is it Qualcomm?) but try
CONFIG_CPU_DCACHE_DISABLE.
2. You are better off programming some DMA master to do large (and
uncached) reads/writes to RAM and timing that.

However simple uncached LDR/STR from the CPU may not be a great
measure of RAM controller perf.

You should always add arm mailing list and please mention the chip set details.
cat /proc/cpuinfo is a great way
>
> How can i achieve this...Any ideas/suggestions...?
>
> --
> With regards,
> Sandeep Kumar Anantapalli,
>
> _______________________________________________
> Kernelnewbies mailing list
> Kernelnewbies at kernelnewbies.org
> http://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies
>
