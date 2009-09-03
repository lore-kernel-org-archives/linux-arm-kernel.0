From: jy0922.shim@samsung.com (Joonyoung Shim)
Date: Thu, 03 Sep 2009 09:21:02 +0900
Subject: Samsung S3C6410 mainline merge coordination
In-Reply-To: <1b68c6790909020644k757827f4kf590779f384ceccb@mail.gmail.com>
References: <20090902031719.GK3838@prithivi.gnumonks.org>
	<20090902100500.GA4012@sirena.org.uk>
	<20090902121158.GU32606@prithivi.gnumonks.org>
	<1b68c6790909020644k757827f4kf590779f384ceccb@mail.gmail.com>
Message-ID: <4A9F0BEE.1060904@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/2/2009 10:44 PM, jassi brar wrote:
> On Wed, Sep 2, 2009 at 9:11 PM, Harald Welte<laforge@gnumonks.org> wrote:
>> On Wed, Sep 02, 2009 at 11:05:01AM +0100, Mark Brown wrote:
>>>> === Sound ===
>>>> * needs further investigation, there are many different drivers/versions/options
>>> Merge any changes in with the mainline drivers - there's relatively
>>> little difference from the s3c24xx IPs. ?here's a reasonable chance
>>> I'll get round to this myself for the 64xx series since I have one which
>>> I'm using for some of my development.
>> Apparently there are also features like operating the SoC codec in slave mode
>> as well as different clock configurations wich mainline is missing.
> 
> Yes, none of mainline SMDK supports SoC-Slave mode or sourcing I2S IP with
> various possible clocks(PCLK, EPLL, CDCLK) etc yet. Samsung tree has
> implemented
> and fully tested these features for 6410, 6440 and C100.
> 
> My idea is to submit only "better enabled" I2S driver with Slave support.
> Clock sourcing related patch maybe later added when the EPLL etc clock
> support has been submitted.
> 
> An issue though.
> In the long run, I see I2S drivers segregated by the I2S spec version
> they implement....
> S3C2410 has I2S-2.0, S3C6410 has I2S-3.2 and I2S-4.0, S5P6440 has
> I2S-4.0, S5PC100 has
> I2S-3.2 and I2S-5.1 and so on. That is, we have something like
> samsung-i2s_v20.c, samsung-i2s_v32.c,
> samsung-i2s_v40.c, samsung-i2s_v51.c.

I wonder what mean the numbers(2.0, 3.2, 4.0, 5.1). Does it mean I2S 
version simply? If it is version, what is the differences of each I2S
version?

> SoC specific register addresses and other peculiarities maybe
> differentiated by defines in coresp. header files.
> Let Samsung come with as many SoCs as it wishes, I2S support will
> simply end up in header files. Also, that we
> can do away with using s3c24xx stuff in 64xx and S5Pxxxx code.
> For now, I haven't implemented h/w mixing and 5.1 channel support so
> v32 and v40 are just the same.
> Whereas, mainline s3c-i2s approach currently concentrates on
> extracting common code in one file(s3c-i2s-v2.c) or so do i think.
> 
> I sincerely seek to discuss this issue.
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
