From: lauri.hintsala@bluegiga.com (Lauri Hintsala)
Date: Thu, 15 Nov 2012 13:51:52 +0200
Subject: [PATCH v2 2/3] serial: mxs-auart: add the DMA support for mx28
In-Reply-To: <50A4B1CE.5070203@freescale.com>
References: <1351074456-25863-1-git-send-email-b32955@freescale.com>
 <1351074456-25863-3-git-send-email-b32955@freescale.com>
 <50A21613.6030709@bluegiga.com> <50A45F83.1010009@freescale.com>
 <50A4983F.8080407@bluegiga.com> <50A4B1CE.5070203@freescale.com>
Message-ID: <50A4D758.8050602@bluegiga.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 11/15/2012 11:11 AM, Huang Shijie wrote:
>> I tested linux-next-20121114 on apx4devkit (imx28 based device) and I
>> got the same error message:
>>
>> # stty -F /dev/ttyAPP0 crtscts; microcom /dev/ttyAPP0 -s 115200
>> [  133.710000] mxs-auart 8006a000.serial: step 1 error
>> [  133.720000] mxs-auart 8006a000.serial: We can not start up the DMA.
> Could you test this patch?

I don't get error messages with your latest patch but the CPU freezes 
after it has received first byte. Freezing happens only if flow control 
(and of course DMA) is enabled. Sending data doesn't freeze the CPU. Are 
you able to send data without freezing?

I used busybox's microcom to transfer data.

Lauri
