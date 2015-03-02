From: aaron@tastycactus.com (Aaron Brice)
Date: Mon, 02 Mar 2015 14:39:49 -0700
Subject: [RFC 2/5] mtd:fsl_nfc: Add hardware 45 byte BHC-ECC support for
 24 bit corrections.
In-Reply-To: <87k2yzqw1r.fsf@nbsps.com>
References: <87siupheou.fsf@nbsps.com>
 <1389222441-4322-1-git-send-email-bpringlemeir@nbsps.com>
 <1389222441-4322-3-git-send-email-bpringlemeir@nbsps.com>
 <127db6b73356442d2ba12e8c011038cc@agner.ch> <87r3zaxgtr.fsf@nbsps.com>
 <c444059de888a661fadf3d6be598a98d@agner.ch> <87lhphyjkg.fsf@nbsps.com>
 <0bc8cec13bcf5b9cbea9cd3345815e4a@agner.ch> <8761dit9u9.fsf@nbsps.com>
 <f3bc6eda0c826601e136f3dad91d9674@agner.ch> <87k2yzqw1r.fsf@nbsps.com>
Message-ID: <54F4D8A5.7020500@tastycactus.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/02/2015 08:05 AM, Bill Pringlemeir wrote:
> On 28 Feb 2015, stefan at agner.ch wrote:
>
>> The flash chip mentioned above requires 8-bit error correction per 512
>> byte block, hence I increased the ECC to the maximum available level
>> (60-byte ECC, see page below). One thing which is not very nice, in
>> order to fit the 60-byte ECC into the 64-byte OOB, I had to shorten
>> the BBT pattern and set it at the very beginning of the page. This
>> works fine, however this basically sets the page also to factory bad,
>> I'm not sure if this is ok? Otherwise, we also could use a BBT pattern
>> of length 1 (used by cafe_nand.c too).
> I guess that is a DT option?  I wouldn't be an expert on this.  So
> submitting it to the linux-mtd is good.
>
> I am also not sure if the HW ECC will work with 'sub-pages'.  I think a
> college of your at Toradex submitted a patch to the u-boot.  I am pretty
> sure that it could work with software ECC, but maybe disabling it is
> easiest.
>
>> What do you think? I would like to respin the NFC patch, with my
>> U-Boot changes and this change included...
> Please go ahead.  Markus M <marb@ixxat.de> is also using the fsl_nfc
> driver on a Freescale MPC5125 board, so it is probably good to copy your
> patches to him.  At least, he can test on a BE platform.
>
> People also complained about JFFS and this version of the driver.  I
> didn't investigate that.

I also noticed a problem with JFFS2 and the driver, where fs changes 
were lost after reboot.  Didn't investigate, switched to UBIFS..
