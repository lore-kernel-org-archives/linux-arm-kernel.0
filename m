From: lucorsel@gmail.com (L.C.)
Date: Tue, 20 Apr 2010 01:11:05 +0200
Subject: Bug#552270: Marvell CESA driver and Kirkwood
In-Reply-To: <20100418191719.GA2508@Chamillionaire.breakpoint.cc>
References: <4B12F9E7.1020207@gmail.com>
	<20091130211531.GK18101@deprecation.cyrius.com>
	<4B144627.7060901@gmail.com>
	<20091204212847.GC28480@deprecation.cyrius.com>
	<4BCB4009.70707@gmail.com>
	<20100418191719.GA2508@Chamillionaire.breakpoint.cc>
Message-ID: <4BCCE309.2050405@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tested with 
git://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git. 
(2.6.33, identical config als the previous 2.6.32)

Although up to 2.6.32 (2.6.32-3 in debian) I got still a recoverable 
OOPS (by removing mv_cesa), with the 2.6.33 cryptodev I get an 
unrecoverable OOPS where the all system hangs. Nasty.

This happens in exactly the same conditions as before (when the ipsec 
connection is estabilished through AES and SHA1 and some traffic tries 
that way. Last row before the crash:
[   41.799083] alg: No test for authenc(hmac(sha1),cbc(aes)) 
(authenc(mvhmac-sha1,mv-cbc-aes))


I'd get the trace via console (of little use really, I guess) or later 
try debug recompile to get some more clue (it will take some time though).

L.

On 18/04/2010 21:17, Sebastian Andrzej Siewior wrote:
> * L.C. | 2010-04-18 19:23:21 [+0200]:
>
>    
>> mv_cesa when enabled on Kirkwood always causes an OOPS whenever
>> openswan tries to use the AES module. I'm talking about 2.6.32.
>>      
> Hmm. I've never tried IPsec. Is it possible to for you test the
> cryptodev git tree [0] ? There were a few patches flying by solving an
> issue where I did not walk correctly through the scatterlist your
> backtrace kinda looks like this could be the issue here.
>
> [0] http://git.kernel.org/?p=linux/kernel/git/herbert/cryptodev-2.6.git;a=summary
>
> Sebastian
>    
