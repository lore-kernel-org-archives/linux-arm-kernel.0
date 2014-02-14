From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Fri, 14 Feb 2014 10:16:20 +0100
Subject: [PATCH v2] can: xilinx CAN controller support.
In-Reply-To: <52FDDE30.8020405@monstr.eu>
References: <\> <0dc128ac-e5cd-47bd-9ab1-3a545c3e2043@CO9EHSMHS012.ehs.local>
 <52FD1B16.6020600@pengutronix.de> <52FDD9FE.8040908@monstr.eu>
 <52FDDC24.8070805@pengutronix.de> <52FDDE30.8020405@monstr.eu>
Message-ID: <52FDDEE4.9060902@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/14/2014 10:13 AM, Michal Simek wrote:
>>> That's not entirely truth. If you look at Microblaze then you will see
>>> that Microblaze can be BE and LE.
>>> There is just missing endian detection which we will add to the next version.
>>
>> As far as I know the endianess of the kernel is fixed and known during
>> compile time. Correct me if I'm wrong. So there is no need for a runtime
>> detection of the endianess and so no need for {read,write}_reg function
>> pointers.
> 
> Endianess of the kernel is fixed and know during compile time
> but what it is not fixed is endianess of that IP at compile time.
> 
> On fpga you can use bridges, partial reconfiguration, etc where
> the only solution which is run-time endian detection via registers.
> 
> For example: drivers/block/xsysace.c, drivers/spi/spi-xilinx.c, etc

Okay, now I get it. You can make it more complex then it used to be :D

Marc

-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 242 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140214/7910cbee/attachment.sig>
