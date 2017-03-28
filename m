From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue, 28 Mar 2017 11:59:48 +0200
Subject: [PATCH] mmc: core: Do not hold re-tuning during CMD6 commands
In-Reply-To: <CAPDyKFq5st=eBW98A1VUjnGwNbocay6gf-7trcUXbUNbUThSBA@mail.gmail.com>
References: <1490336341-22292-1-git-send-email-chaotian.jing@mediatek.com>
 <1490336341-22292-2-git-send-email-chaotian.jing@mediatek.com>
 <13a83728-0031-5683-c371-4b517df32299@intel.com>
 <1490344369.22814.10.camel@mhfsdcap03>
 <03d54000-9ced-1b31-df80-d254f02433db@intel.com>
 <1490348427.22814.19.camel@mhfsdcap03>
 <CAPDyKFoo5sJ2XtjyiW1DLjhFdJySbDK7+N05vrKpeiZsp25qrA@mail.gmail.com>
 <1490578500.22814.31.camel@mhfsdcap03>
 <CAPDyKFoWyVrdk7bG1n=rTSOddvqaj-uTO70QoGmcKQK1Fhio2w@mail.gmail.com>
 <a0df1a1d-a776-f1e6-1ee2-e66faff375d3@intel.com>
 <CAPDyKFq5st=eBW98A1VUjnGwNbocay6gf-7trcUXbUNbUThSBA@mail.gmail.com>
Message-ID: <CAPDyKFo=DwzUqFZzh0tcRiYg6GagL8VrXwpd6PyfdZ+qkYgXqw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[...]

>> The retry mechanism provided by mmc_wait_for_cmd() and friends really only
>> makes sense for simple commands.  In other cases, like this, we need to
>> consider what state the card is in.  For __mmc_switch we need to consider
>> whether the card is busy or whether a timing change been made.
>
> I definitely agree. We should remove retries for CMD6 and perhaps also
> for some other cases.
>
> When we have changed the above in __mmc_switch(), the change Chaotian
> suggest gets a different impact, as it would potentially allow a
> re-tuning to happen before the next CMD1to poll for busy or to check

/s/CMD1/CMD13

> the switch status. This isn't okay.
>
> This all sounds to me that Chaotian's issue may not all be related to
> tuning, but to the CMD6 switch sequence itself. However I may be wrong
> - of course. :-)
>
> [...]
>
> Kind regards
> Uffe
