From: robh@kernel.org (Rob Herring)
Date: Mon, 11 May 2015 19:35:24 -0500
Subject: [PATCH v3 1/4] ARM: pxa: add memory resource to RTC device
In-Reply-To: <20150511224934.GL2067@n2100.arm.linux.org.uk>
References: <1431384089-28367-1-git-send-email-robh@kernel.org>
 <1431384089-28367-2-git-send-email-robh@kernel.org>
 <20150511224934.GL2067@n2100.arm.linux.org.uk>
Message-ID: <CAL_Jsq+tNStipTDRH05XRHVDz30B8w92YTD1ZKUTrCp-Lj7=1w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 11, 2015 at 5:49 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, May 11, 2015 at 05:41:26PM -0500, Rob Herring wrote:
>> Add the memory resource for the sa1100-rtc device. Since the memory
>> resource is already present in the pxa_rtc_resources, that makes
>> sa1100_rtc_resources and pxa_rtc_resources equivalent, so use
>> pxa_rtc_resources for both devices and remove the duplicate
>> sa1100_rtc_resources.
>
> This really isn't a good idea - what do you think happens when
> the same struct resource gets passed into insert_resource()
> twice?

Bad things. If you recall, we discussed this on v1[1]. See the commit
msg of patch 2 for the summary. There is not currently a problem
because the rtc-pxa driver does not request the resource.

Rob

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-February/322355.html

>
> --
> FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
> according to speedtest.net.
