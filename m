From: skannan@codeaurora.org (Saravana Kannan)
Date: Tue, 10 May 2011 13:06:55 -0700
Subject: [PATCH 01/10] Add a common struct clk
In-Reply-To: <alpine.DEB.2.00.1105041732290.30136@utopia.booyaka.com>
References: <1302894495-6879-1-git-send-email-s.hauer@pengutronix.de>	<1302894495-6879-2-git-send-email-s.hauer@pengutronix.de>	<4DBDC3B5.7070808@gmail.com>
	<1304298586.2686.29.camel@pororo>	<4DBE2064.2060303@gmail.com>
	<1304307632.2686.33.camel@pororo>	<4DBEDC12.4090203@gmail.com>	<20110502223636.GB28001@n2100.arm.linux.org.uk>
	<alpine.DEB.2.00.1105041732290.30136@utopia.booyaka.com>
Message-ID: <4DC99ADF.7080903@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/04/2011 04:35 PM, Paul Walmsley wrote:
> Hi
>
> On Mon, 2 May 2011, Russell King - ARM Linux wrote:
>
>> This does bring us to an interesting question though: should clk_set_rate()
>> succeed or fail with a NULL clk?  There is no clock to control, so my
>> feeling is that it should fail, just like clk_get_rate() should return
>> zero because the rate is meaningless.  There is no rate to get and no
>> rate to set.
>
> Returning an error would be my preference when a NULL or bogus clock
> pointer is passed to any clk_* operation, especially since those
> operations will need to dereference the clock pointer.

Wouldn't returning an error for all clk_* ops for a NULL clock make it 
meaningless? It would be the same as -ENOENT in that case.

-Saravana

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
