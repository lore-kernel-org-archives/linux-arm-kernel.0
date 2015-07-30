From: rsahu@apm.com (Rameshwar Sahu)
Date: Thu, 30 Jul 2015 14:21:07 +0530
Subject: [PATCH] dmaengine: xgene-dma: Add ACPI support for X-Gene DMA
 engine driver
In-Reply-To: <2384915.JHlOHWBXHy@wuerfel>
References: <1437484479-2822-1-git-send-email-rsahu@apm.com>
 <2384915.JHlOHWBXHy@wuerfel>
Message-ID: <CAFd313xntHx7JhfTWSsJo+bTm-DuEcbAzqXt9in1s0irL3g7sw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Wed, Jul 29, 2015 at 8:04 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 21 July 2015 18:44:39 Rameshwar Prasad Sahu wrote:
>> This patch adds ACPI support for the APM X-Gene DMA engine driver.
>>
>> Signed-off-by: Rameshwar Prasad Sahu <rsahu@apm.com>
>>
>
> How does a slave driver refer to a channel in case of ACPI?

We don't support slave dma here. This driver supports only memcp, xor,
pq, scatter-gather offloading, so,
client driver can use linux dmaengine APIs like dma_request_channel()
etc to request channel.


>
>         Arnd
> --
> To unsubscribe from this list: send the line "unsubscribe dmaengine" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
