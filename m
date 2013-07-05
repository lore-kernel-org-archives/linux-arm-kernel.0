From: sourav.poddar@ti.com (Sourav Poddar)
Date: Fri, 5 Jul 2013 14:57:51 +0530
Subject: SPI: DUAL/QUAD support
In-Reply-To: <CAHSAbzMfvfdDtTh=3zeBni4fNMAHEMdTJLJU-Oc13HJUqCUj0A@mail.gmail.com>
References: <CAHSAbzPNDSr_6N79fh0DTWSEg8buRRPyiw8SPodtKLPjzWXJsg@mail.gmail.com>	<20130704130017.GA25997@sig21.net>	<OFA0D5839D.0594EA10-ONC1257B9E.004A7347-C1257B9E.00524BA5@rohde-schwarz.com>	<20130704154927.GE27646@sirena.org.uk>	<OFAD729A05.8C915625-ONC1257B9E.00576B25-C1257B9E.0058477D@rohde-schwarz.com>	<CAHSAbzOg+uHndydSC43moF7pijc67pqzB2rPnY69ynXHEzw79g@mail.gmail.com>	<51D67851.8020402@ti.com>	<CAHSAbzNvMo_oeaqtzO8-xDm-L-f8wVccVqfuVqbR=OwqWJhVwg@mail.gmail.com>	<51D689F3.3070605@ti.com>	<CAHSAbzM1PGoMXFNOmB7guDsVWYnRoRy89-bufHYpPz5+odnd8w@mail.gmail.com>	<51D68D14.7090606@ti.com>
 <CAHSAbzMfvfdDtTh=3zeBni4fNMAHEMdTJLJU-Oc13HJUqCUj0A@mail.gmail.com>
Message-ID: <51D69197.7060802@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 05 July 2013 02:47 PM, yuhang wang wrote:
> 2013/7/5 Sourav Poddar<sourav.poddar@ti.com>:
>> On Friday 05 July 2013 02:37 PM, yuhang wang wrote:
>>>>                       if (!quad_mode)
>>>>                               dra7xxx_writel(qspi, qspi->cmd |
>>>> QSPI_RD_SNGL,
>>>>                                               QSPI_SPI_CMD_REG);
>>>>                       else
>>>>                               dra7xxx_writel(qspi, qspi->cmd |
>>>> QSPI_RD_QUAD,
>>>>                                               QSPI_SPI_CMD_REG);
>>>>                    .......
>>>>                   }
>>> So what do you based on to set variable quad_mode.
>> Best way should be to check for flash device id and manufacture data. Based
>> on which you
>> can decide whether your flash supports quad bits or not.
> Perhaps I did not said it clearly. Your flash supports quad and you
> set it into quad
> mode. But how can your controller driver notice that. In other word,
> In which way
> provide this information from flash to spi controller.
Perhaps, I understood you initial patch wrong. :(
Yes, this is little confusing, and I am trying to figure out that.
As of now, I have tested it with some extern variable, though
we need to see how it can be done cleanly.
I am trying to see if your patch can be used in some way now.
