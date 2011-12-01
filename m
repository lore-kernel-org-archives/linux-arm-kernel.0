From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 1 Dec 2011 14:01:46 +0100
Subject: [PATCH] mmc: mmci: Fixup error handling for dma
In-Reply-To: <20111130222139.GW9581@n2100.arm.linux.org.uk>
References: <1322578286-18727-1-git-send-email-ulf.hansson@stericsson.com>
 <20111130222139.GW9581@n2100.arm.linux.org.uk>
Message-ID: <CACRpkdacJxbFvSuXTsxtjZVbeTaJwNN4xy7-rvpa0U0Z4pDE_g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 30, 2011 at 11:21 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

>> ? ? ? if (!cmd->data || cmd->error) {
>> - ? ? ? ? ? ? if (host->data)
>> + ? ? ? ? ? ? if (host->data) {
>> + ? ? ? ? ? ? ? ? ? ? /* Terminate the DMA transfer */
>> + ? ? ? ? ? ? ? ? ? ? if (dma_inprogress(host))
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? mmci_dma_data_error(host);
>
> Doesn't this leave the DMA buffers mapped?

Yep it needs an mmci_dma_unmap() call too AFAICT,
Ulf will you update?

Yours,
Linus Walleij
