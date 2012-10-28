From: jm@lentin.co.uk (Jamie Lentin)
Date: Sun, 28 Oct 2012 21:53:09 +0000 (GMT)
Subject: [PATCH] ARM: kirkwood: Increase NAND chip-delay for DNS-320
In-Reply-To: <20121028205956.GH15143@lunn.ch>
References: <1351457262-11506-1-git-send-email-jm@lentin.co.uk>
 <20121028205956.GH15143@lunn.ch>
Message-ID: <alpine.DEB.2.00.1210282123250.10589@marmot.wormnet.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 28 Oct 2012, Andrew Lunn wrote:

> On Sun, Oct 28, 2012 at 08:47:42PM +0000, Jamie Lentin wrote:
>> The default chip-delay of 25ns is a bit too tight for some DNS-320's,
>> increase to 35ns.
>>
>> Signed-off-by: Jamie Lentin <jm@lentin.co.uk>
>> ---
>> I now own 2 DNS-320's, the first of which is happy with a mainline
>> kernel, the second fills the console with "Bad eraseblock xxx at
>> 0x00000xxxxxxx" for every eraseblock and refuses to access the NAND.
>> Beyond this they appear identical, and report the same NAND chip
>> (I haven't physically checked that it's the same, however).
>>
>> The patch below fixes it, however:-
>> * Is there something else I should be trying, rather than potentially
>> masking the problem?
>> * Is chip-delay too low for kirkwood generally?
>
> Do you know what NAND chip it is? We can check the datasheet and see
> what is specified.

The chip markings are: SAMSUNG 146 K9F1G08U0D SCB0 (FKJ554PWN)

Unfortunately the other NAS is too far away to get at, but D-link haven't 
stuck to exactly the same chip. This DNS-320 review shows a different 
Samsung part:

http://diit.cz/data/images/thumb/67491_2b9e5e4fbd.jpg?1307884464

The datasheet for the K9F1G08U0D says max 35usecs "Data Transfer from Cell 
to Register", whereas K9F1G08U0C (what the DNS-320 review shows) says 
25usecs. If this is the value in the datasheet to check, then this would 
explain the problems.

> All kirkwood's use 25ns and i don't think there have been any problems
> reported. But that does not mean Dlink have mounted a slower device.

I've not had anyone with this NAS report similar problems. It could just 
be I've been particuarly lucky...

>
> 	  Andrew
>

-- 
Jamie Lentin
