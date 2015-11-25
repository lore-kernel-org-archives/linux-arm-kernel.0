From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 25 Nov 2015 23:40:07 +0100
Subject: [PATCH v2 1/3] ARM: qcom: Make an option for qcom clocksource
 platforms
In-Reply-To: <5656349D.70103@codeaurora.org>
References: <1448485478-21699-1-git-send-email-sboyd@codeaurora.org>
 <6140735.DAZiajTbh1@wuerfel> <5656349D.70103@codeaurora.org>
Message-ID: <3228474.gifZbHXqvC@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 25 November 2015 14:22:21 Stephen Boyd wrote:
> 
> >
> > Is there any common way to classify these, e.g. calling them
> > 'pre-2013 models' or 'Snapdragon S4' as a way to identify them?
> 
> I was thinking I could leave it as ARCH_MSM_8X60 because that covers the
> 6 and the 9, but that doesn't make me feel great. I have no idea what
> Snapdragon S4 is, and that didn't exist when 8660 was first released.
> pre-2013 models seems alright. Or perhaps ARCH_QCOM_PRE_8974?
> 
> Internally (and sort of leaked externally now) we called MSM8960 and its
> variants A-family, and the generation after B-family, so perhaps
> ARCH_QCOM_A_FAMILY would be appropriate? The problem there is no end
> user knows about this distinction.

I think using internal code names like ARCH_QCOM_A_FAMILY here is fine,
a lot of other platforms do similar things. Regarding end users,
it's probably enough to explain the distinction in the help text,
something like:

	The A-family includes all Snapdragon S1/S2/S3/S4 chips before 2013,
	up to the MSM8x60 and APQ8064 models.

	The B-family includes all Snapdragon 2xx/4xx/6xx/8xx models starting
	in 2013 with the MSM8x74.

https://en.wikipedia.org/wiki/List_of_Qualcomm_Snapdragon_device has
a good overview that translates the marketing names into the model
numbers but it doesn't have internal code names, so I'm not sure where the
APQ8064 fits it, as it was marketed as both the "S4 Pro" and the "600",
depending on the revision.

	Arnd
