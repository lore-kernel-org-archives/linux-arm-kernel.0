From: cjb@laptop.org (Chris Ball)
Date: Mon, 09 Jul 2012 23:18:33 -0400
Subject: [PATCH] mmc: atmel-mci: fix incorrect setting of host->data to
 NULL
In-Reply-To: <4FF6B831.5060005@atmel.com> (ludovic desroches's message of
 "Fri, 6 Jul 2012 12:04:33 +0200")
References: <1341568713-8869-1-git-send-email-nicolas.ferre@atmel.com>
 <4FF6B831.5060005@atmel.com>
Message-ID: <87sjd0tiba.fsf@octavius.laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jul 06 2012, ludovic.desroches wrote:
> Le 07/06/2012 11:58 AM, Nicolas Ferre a ?crit :
>> Setting host->data to NULL is incorrect sequence in STATE_SENDING_STOP
>> state of FSM: This early setting leads to the skip of dma_unmap_sg()
>> in atmci_dma_cleanup() which is a bug.
>>
>> Idea taken form dw_mmc by Seungwon Jeon.
>>
>> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
>> Cc: Seungwon Jeon <tgih.jun@samsung.com>
>
> Acked-by: Ludovic Desroches <ludovic.desroches@atmel.com>

Thanks, pushed to mmc-next for 3.6.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
