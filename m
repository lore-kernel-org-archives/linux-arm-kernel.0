From: rusko.peter@prolan.hu (Peter Rusko)
Date: Wed, 30 Nov 2011 16:05:52 +0100
Subject: [PATCH] mx28: added LRADC and touchscreen support
In-Reply-To: <201111291909.43833.arnd@arndb.de>
References: <1322135394-4097-1-git-send-email-rusko.peter@prolan.hu>
 <201111251602.35227.arnd@arndb.de> <4ED21E4E.5090004@cam.ac.uk>
 <201111291909.43833.arnd@arndb.de>
Message-ID: <4ED64650.4030402@prolan.hu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2011-11-29 20:09, Arnd Bergmann wrote:
> On Sunday 27 November 2011, Jonathan Cameron wrote:
>
>>> As indicated by Shawn, adding a new driver specific kernel-level ADC
>>> interface is not a good idea. IIRC, the result of the last discussion
>>> was that all ADC drivers should be part of IIO and you should use
>>> the IIO in-kernel interfaces. Not sure what the state of that code
>>> is, but if it's not in mainline yet, you should work with Jonathan
>>> to make sure it gets there. Having more users for that code can
>>> only speed up the process, and I'm going to refuse another ADC driver
>>> in drivers/misc or arch/arm/mach-*/.
>>
>> Quick summary of IIO status.  Nothing is in mainline yet.  Intent is to
>> get the first set of core code (including in kernel pull interfaces)
>> into linux-next fairly shortly (these have had enough postive feedback
>> now I think).  Doing push interfaces (as I think we would need here) is
>> possible with existing patches on top of the stuff in the iio staging
>> tree but there are some 'interesting' cases where both push and pull
>> interfaces exist that still need addressing.
>>
>> Also, note the push interface stuff (e.g. interrupt driven) requires a
>> lot more of the IIO infrastructure to be in place (buffered support and
>> the demux unit) so may still be some time.  Personally my time is
>> currently very restricted so all the help anyone can offer is most welcome!
>
> Ok, thanks for the summary!
>
> Peter, I guess what this means for you is that it's best to first
> get your code working with the IIO/ADC stuff that is in staging,
> and get the touchscreen driver ready for merging, on top of that.
>
> Ideally, you would also help out a bit on getting the IIO parts
> you need graduated from staging. Given Jonathan's explanation,
> I think my initial reaction was valid: we shouldn't take the
> ADC driver outside of IIO, because that ends up being more painful
> than getting the driver ready for inclusion now, and then rewriting
> it shortly after.
>
> 	Arnd
>

Thank you all for your comments. I'm now working on the interface
change to iio, it may take some time...
I've also applied most of the suggestions, they'll be in the next
patches.

-- 
Rusk? P?ter
Fejleszt?m?rn?k

Prolan Zrt. / Prolan Co.
Hungary 2011 Budakal?sz, Szentendrei ?t 1-3.
Tel./Phone: +36 20 954 3118
Fax: +36 26 540 420
E-mail: rusko.peter at prolan.hu
Web: www.prolan.hu
Timezone:CET
