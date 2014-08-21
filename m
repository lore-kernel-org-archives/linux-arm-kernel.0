From: fransklaver@gmail.com (Frans Klaver)
Date: Fri, 22 Aug 2014 00:07:22 +0200
Subject: [RFC PATCH 3/4] tty: omap-serial: use threaded interrupt handler
In-Reply-To: <20140821214840.GU11146@saruman.home>
References: <1406645577-18620-1-git-send-email-frans.klaver@xsens.com>
 <1408450488-4083-1-git-send-email-frans.klaver@xsens.com>
 <1408450488-4083-4-git-send-email-frans.klaver@xsens.com>
 <20140819185701.GC22003@saruman.home>
 <20140820064028.GC9319@ci00147.xsens-tech.local>
 <20140820160604.GH24500@saruman.home>
 <20140821214117.GA7076@ci00147.xsens-tech.local>
 <20140821214840.GU11146@saruman.home>
Message-ID: <c5a0e820-cd57-43d0-85db-1297a83861c5@email.android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On August 21, 2014 11:48:40 PM CEST, Felipe Balbi <balbi@ti.com> wrote:
>Hi,
>
>On Thu, Aug 21, 2014 at 11:41:17PM +0200, Frans Klaver wrote:
>> On Wed, Aug 20, 2014 at 11:06:05AM -0500, Felipe Balbi wrote:
>> > On Wed, Aug 20, 2014 at 08:40:28AM +0200, Frans Klaver wrote:
>> > > On Tue, Aug 19, 2014 at 01:57:02PM -0500, Felipe Balbi wrote:
>> > > > On Tue, Aug 19, 2014 at 02:14:47PM +0200, Frans Klaver wrote:
>> > > > > At 3.6Mbaud, with slightly over 2Mbit/s data coming in, we
>see 1600 uart
>> > > > > rx buffer overflows within 30 seconds. Threading the
>interrupt handling reduces
>> > > > > this to about 170 overflows in 10 minutes.
>> > > > 
>> > > > Can you try Sebastian Siewior's patches for 8250_omap and 8250
>dma
>> > > > support ? That should help you a lot.
>> > > 
>> > > I'll have a look at that series. Thanks for pointing it out.
>> 
>> I have had a look at Sebastian's series, but I'm not convinced
>> yet that we should use it. So far the serial console seems to be
>> missing data every now and then. I haven't gotten around to testing
>our
>> high traffic application yet.
>
>as any new driver, there are bugs to be fixed. How about reporting the
>ones you found together with a way of reproducing them so they can be
>fixed ?

Yes, definitely.

Cheers, 
Frans
