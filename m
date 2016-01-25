From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Mon, 25 Jan 2016 13:51:09 +0100
Subject: [PATCH 1/2] regulator: ltc3589: make IRQ optional
In-Reply-To: <20160125124123.GQ6588@sirena.org.uk>
References: <20160120164258.GF6588@sirena.org.uk>
 <20160121080524.27af489f@ipc1.ka-ro>
 <20160121102015.GI6588@sirena.org.uk>
 <20160121112611.34e17cb2@ipc1.ka-ro>
 <20160121111115.GJ6588@sirena.org.uk>
 <20160121123311.5346e40d@ipc1.ka-ro>
 <20160121162646.GK6588@sirena.org.uk>
 <20160122064145.36b7f2b4@ipc1.ka-ro>
 <20160122162610.GZ6588@sirena.org.uk>
 <20160125133731.72669115@ipc1.ka-ro>
 <20160125124123.GQ6588@sirena.org.uk>
Message-ID: <20160125135109.760ba5f0@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, 25 Jan 2016 12:41:23 +0000 Mark Brown wrote:
> On Mon, Jan 25, 2016 at 01:37:31PM +0100, Lothar Wa?mann wrote:
> > On Fri, 22 Jan 2016 16:26:10 +0000 Mark Brown wrote:
> 
> > > You're not just making the interrupt optional, you are also implementing
> > > polling support.  That's really unusual and there's no clear reason for
> 
> > Any suggestions how to handle this case in a more sensible way?
> 
> The above, for example - make the interrupt optional.
>
This will make it impossible to notify the system about
overtemperature (and undervoltage).
I implemented polling to be able to get at least overtemperature
warnings.
(Undervoltage cannot be handled sensibly without interrupt anyway)


Lothar Wa?mann
