From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sun, 27 Jan 2013 15:19:13 +0100
Subject: [PATCH v2 1/2] ARM: kirkwood: Ensure that kirkwood_ge0[01]_init()
 finds its clock
In-Reply-To: <20130127110857.GA23687@schnuecks.de>
References: <1359283223-23082-1-git-send-email-gmbnomis@gmail.com>
 <1359283223-23082-2-git-send-email-gmbnomis@gmail.com>
 <510506F9.3070500@gmail.com> <20130127110857.GA23687@schnuecks.de>
Message-ID: <51053761.1020009@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/27/2013 12:08 PM, Simon Baatz wrote:
> Hi Sebastian,
>
> On Sun, Jan 27, 2013 at 11:52:41AM +0100, Sebastian Hesselbarth wrote:
>> Jason posted a patch set that makes mv643xx DT compatible. IMHO this
>> patch is obsolete when we have DT support for mv643xx.
>> kirkwood_ge00/01_init will not be called with DT support at all.
>
> I know. This is to fix a regression in 3.8 (which currently does not
> boot with my "modularized" config).

Simon,

I _cannot_ confirm that gbe is loosing its MAC address on Dove. I will
post a follow-up patch to Jason's cleanup patches that will also
grab a clock for smi. With that patch insmod'ing/rmmod'ing mv643xx_eth
does work just fine here on Dove.

Sebastian
