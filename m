From: mmarek@suse.com (Michal Marek)
Date: Fri, 27 Nov 2015 15:50:05 +0100
Subject: [PATCH] logfs: clarify MTD dependency
In-Reply-To: <3269089.8XYbbcUOLH@wuerfel>
References: <9365895.IkncCfXjo6@wuerfel>
 <20151127141406.GA29886@sepie.suse.cz> <3269089.8XYbbcUOLH@wuerfel>
Message-ID: <56586D9D.1000603@suse.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015-11-27 15:30, Arnd Bergmann wrote:
> On Friday 27 November 2015 15:14:06 Michal Marek wrote:
>>
>> Hi Arnd,
>>
>> I hit this as well and was about to submit a slightly different fix. Can
>> you try the logfs portion of the below patch? Proper changelog is to be
>> done, but the gist of the patch is that IS_REACHABLE(CONFIG_FOO) 
>> evaluates to 1 if CONFIG_FOO=y or we are building a module and
>> CONFIG_FOO=m.
>>
> 
> I thought about doing it that way, and I'm sure that also worked.
> The possible behaviors are basically:
> 
> a) before your original patch, building logfs with CONFIG_MTD=m would
>    silently leave out MTD support, which was rather confusing.
> 
> b) with my patch, it becomes impossible to have logfs as the built-in
>    root file system on a block device while also using CONFIG_MTD=m,
>    and that may be slightly annoying
> 
> c) your patch restores a), but makes it work in the case where both
>    logfs and mtd are loadable modules, which is an improvement but
>    may still confuse users.
> 
> My preference is still version b) as I sent, but I don't really mind
> your version either.

I used the IS_REACHABLE macro because it hides the boolean expressions
nicely :). But I also do not insist on a particular solution. J?rn, what
would be your preference?

Thanks,
Michal
