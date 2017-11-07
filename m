From: guillaume.tucker@collabora.com (Guillaume Tucker)
Date: Tue, 7 Nov 2017 11:43:45 +0000
Subject: next/master boot: 273 boots: 63 failed, 209 passed with 1
 untried/unknown (next-20171106)
In-Reply-To: <20171107105501.7x74gdqzhr7uulp2@sirena.org.uk>
References: <5a0055f1.85a8500a.98d54.a4e4@mx.google.com>
 <20171106191713.d7jqg2b6zqchythw@sirena.co.uk>
 <d8e21d87-776b-beff-62af-34e5ad1febc3@nvidia.com>
 <20171107105501.7x74gdqzhr7uulp2@sirena.org.uk>
Message-ID: <a384e96c-27c7-782b-75b9-7525714f5831@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/11/17 10:55, Mark Brown wrote:
> On Tue, Nov 07, 2017 at 10:12:59AM +0000, Jon Hunter wrote:
>> On 06/11/17 19:17, Mark Brown wrote:
>
>>>>     multi_v7_defconfig:
>>>>         tegra124-nyan-big:
>>>>             lab-collabora: failing since 2 days (last pass: next-20171102 - first fail: next-20171103)
>
>> Thanks for the report. I have been looking into a failure on nyan-big
>> [0], but this one looks like a new failure. I will take a look.
>
> Guillaume Tucker has been bisecting this with the shiny new bisection
> code he's testing, he was saying on IRC he thinks he's found the
> offending commit:
>
>    https://people.collabora.com/~gtucker/tmp/bisect-tegra-4.14.rc8-next-20171106.txt
>
> (not CCing Johannes yet)

Please take this with a pinch of salt, I'm now running some extra
boot tests to prove it.  If you look at this log, all the boots
passed which is a bit suspicious.  I did build and boot the
revision it found with multi_v7_defconfig on tegra124 and it
passed, so it looks like this commit may not have anything to do
with the boot failure.  The automated bisection is still experimental.

Passing LAVA boot test with this revision:

   https://lava.collabora.co.uk/scheduler/job/976375

I've started a slightly different bisection job now on
next-20171107 and the common ancestor between next and mainline,
results can take a few hours to come back.

Guillaume
