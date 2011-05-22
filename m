From: sameo@linux.intel.com (Samuel Ortiz)
Date: Sun, 22 May 2011 22:24:06 +0200
Subject: [PATCH v4 01/11] mfd: add pruss mfd driver.
In-Reply-To: <201105142233.53659.arnd@arndb.de>
References: <1303474109-6212-1-git-send-email-subhasish@mistralsolutions.com>
	<EAA964D5CCD94B4A9544B294E0CF5099@subhasishg>
	<20110514160126.GA2791@opensource.wolfsonmicro.com>
	<201105142233.53659.arnd@arndb.de>
Message-ID: <20110522202405.GF18610@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Sat, May 14, 2011 at 10:33:53PM +0200, Arnd Bergmann wrote:
> On Saturday 14 May 2011, Mark Brown wrote:
> > > Will a misc device be a better choice.
> > 
> > > In that case I can remove the MFD cell from the board_file and add an array
> > > of platform_device for the UART & CAN.
> > 
> > I think that for me so long as it can simultaneously do two unrelated
> > functions which need to be arbitrated between there's probably a place
> > for it in MFD, certainly at the minute.
> 
> I guess drivers/mfd would be a better place than drivers/misc, but it might not
> need to be an mfd driver in the sense that it registers mfd cells.
> 
I agree with that. Although if it makes it to drivers/mfd/, I'd prefer to see
it using the MF API.


> The more important point is to remove the device registration from the board
> file. You definitely should not have the cells in the board file, but replacing
> them with platform devices in the board file makes it no better.
> 
> My whole point has been that you register them from the main pruss driver
> based on run-time data instead of compile-time pre-configured stuff in the
> board file.
That's certainly right.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
