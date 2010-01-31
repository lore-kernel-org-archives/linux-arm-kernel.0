From: anti.sullin@artecdesign.ee (Anti Sullin)
Date: Mon, 01 Feb 2010 00:34:44 +0200
Subject: [patch v2 1/2] at91_udc.c read_fifo timing issue
In-Reply-To: <20100129162155.709756286@gmail.com>>
References: <20100129162029.998540038@gmail.com>>
	<20100129162155.709756286@gmail.com>>
Message-ID: <4B660584.7020302@artecdesign.ee>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Harro Haan wrote:
 > This solves the read_fifo timing issue for example seen with CDC 
Ethernet.
[...]

Still this bug not fixed?
I sent almost the same fix and a lot of debug info with description of 
the issue and the critical path of the timing to linux-arm-kernel on 
2009-03-25 ( 
http://lists.arm.linux.org.uk/lurker/message/20090325.150843.f515c02f.en.html 
) and we had an off-list discussion with David Brownell about another 
udc patch on 2009-06-19 that later turned out to be the same issue.

This fix has solved the problems on our devices and we've been using it 
for almost a year now.

About Harro's patch:
* why are the marker1 and marker2 comments necessary to be included?
* maybe you should just link to the mailing list and/or move the long 
comment to patch description instead adding a page-long comment to code; 
just leave a small comment to explain why the work-around is needed so 
that nobody would optimize it away?
* Is the error check and warning message necessary after we've got rid
of the problem? Won't it add problems - as I found out, the first csr
read (that comes too early) may return bogus data, you should not use 
its result at all.

-- 
Anti Sullin
Embedded Software Engineer
Artec Design LLC
Teaduspargi 6/2, 12618, Tallinn, Estonia
http://www.artecdesign.ee
