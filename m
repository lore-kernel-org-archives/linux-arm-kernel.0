From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 17 May 2012 23:00:07 -0300
Subject: Issues when running DT enabled kernel on iMX28 from linux-next
In-Reply-To: <CAAQ0ZWRB1=pFqtL_2y-D-f4_VM21o9U1G9F3PMwNgM4ewKmkWQ@mail.gmail.com>
References: <4FB583CF.2080801@grid-net.com>
 <20120518010138.GA5427@S2101-09.ap.freescale.net>
 <CAOMZO5D679an+-iaUBXZy+PmHB2tAHhYHUAFWY+4rxSOYiBkyw@mail.gmail.com>
 <CAAQ0ZWRB1=pFqtL_2y-D-f4_VM21o9U1G9F3PMwNgM4ewKmkWQ@mail.gmail.com>
Message-ID: <CAOMZO5Aj0cfpJwMEQwOvM9cM52=W5Rtr5kKxqgw1JG_5AQ5t+g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 17, 2012 at 10:58 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
> On 18 May 2012 09:50, Fabio Estevam <festevam@gmail.com> wrote:
>> Could you please confirm next-20120517 also boots?
>>
>> I am not getting nothing on console.
>>
>> This is my U-boot setup:
>>
>> run netargs; tftpboot 42000000 uImage; tftpboot 42800000
>> imx28-evk.dtb; bootm 0x4000000 - 0x42000000
>>
> The addresses in bootm mismatch the ones in tftpboot?

Sorry, my typo. The line I use is:

run netargs; tftpboot 42000000 uImage; tftpboot 42800000
imx28-evk.dtb; bootm 0x42000000 - 0x42800000

This is what I see:

TFTP from server 192.168.1.105; our IP address is 192.168.1.107
Filename 'uImage'.
Load address: 0x42000000
Loading: #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         ###################################################
done
Bytes transferred = 2255688 (226b48 hex)
Using FEC0 device
TFTP from server 192.168.1.105; our IP address is 192.168.1.107
Filename 'imx28-evk.dtb'.
Load address: 0x42800000
Loading: ##
done
Bytes transferred = 9340 (247c hex)
## Booting kernel from Legacy Image at 42000000 ...
   Image Name:   Linux-3.4.0-rc7-next-20120517
   Created:      2012-05-18   1:37:46 UTC
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    2255624 Bytes = 2.2 MiB
   Load Address: 40008000
   Entry Point:  40008000
   Verifying Checksum ... OK
## Flattened Device Tree blob at 42800000
   Booting using the fdt blob at 0x42800000
   Loading Kernel Image ... OK
OK
   Loading Device Tree to 47b7d000, end 47b8247b ... OK

Starting kernel ...

Uncompressing Linux... done, booting the kernel.

(No output after that)
