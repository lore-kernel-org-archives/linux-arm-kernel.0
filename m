From: bp@alien8.de (Borislav Petkov)
Date: Fri, 21 Apr 2017 20:12:21 +0200
Subject: [PATCH V15 03/11] cper: add timestamp print to CPER status
 printing
In-Reply-To: <a20143dc-8daa-102b-d929-4d96f73353e3@codeaurora.org>
References: <1492556723-9189-1-git-send-email-tbaicar@codeaurora.org>
 <1492556723-9189-4-git-send-email-tbaicar@codeaurora.org>
 <20170421122150.76cce2cfrt767glv@pd.tnic>
 <35cc4ae0-e8fa-fd3a-5d7f-243ed2e82ea0@codeaurora.org>
 <20170421172603.4574wonnm5tgvbcn@pd.tnic>
 <a20143dc-8daa-102b-d929-4d96f73353e3@codeaurora.org>
Message-ID: <20170421181221.4qqfprbyljgv4ekb@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 21, 2017 at 12:08:43PM -0600, Baicar, Tyler wrote:
> The timestamp may still be useful when it is imprecise. In the polling case,
> you may only poll every minute or so, so the time may be useful.

Well, what is in the timestamp when !precise? Some random time or some
timestamp from a couple of seconds ago? How do you differentiate what
timestamp is bollocks and what is from a while ago?

Is the imprecise tstamp really close to the time the error happened or
pointing at 1970 - the beginning of unix time? :-)

I'm sure you've picked up by now that we don't trust the firmware one
bit.

> Also, I imagine there could be interrupt based errors happening much faster than the
> FW/OS handshake can happen. Maybe we can just use what I had before but also
> specify imprecise so that it is clear:
> 
>         printk("%s%ststamp: %02d%02d-%02d-%02d %02d:%02d:%02d\n", pfx,
>             (timestamp[3] & 0x1 ? "precise " : "imprecise "),
>              century, year, mon, day, hour, min, sec);

I guess.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
