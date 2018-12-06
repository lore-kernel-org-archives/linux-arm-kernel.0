Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5726C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:40:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B407F208E7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:40:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jI0Tc0FL";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Qw0CprXM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="UrnMTssT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B407F208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=CDkOCZv4iyhF3zg3YxQ1Ww8Zk1PQvy0Nex5Ju0NisW8=; b=jI0Tc0FLV2NpW4
	OXO6bI6KKMUKRzd3EUsqL+PwxP2wCqv1b1c0nfZhvsZSr7yJGfqS/Invb/duxpbcP4/bE+cCFMn6k
	jOjzV971fQtIkZOH8em52dZHxw3damGGco0uZNsY695zS+tDFbkaUD3qh5rGL4TQ7EYp6F7XlJ0ml
	nqxj203mkk2BsKwXjwrJh0zOhHlMXhpvSiQzPQzEJg3Jpu1LetAm7+HhTLDQVAZMOQ8/mO9oo0wD4
	yZYSPxwKreQdNqFlHLD73XJyp0RHMHG5I+zaBkmBprt6tSwrbS3ZiexHVGUzMYZ48MFoOXDaef7zt
	wsxT9tGwmMX7PMBE/2rg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUttd-0005aS-DW; Thu, 06 Dec 2018 13:40:53 +0000
Received: from casper.infradead.org ([85.118.1.10])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUtgb-0007JS-TG
 for linux-arm-kernel@bombadil.infradead.org; Thu, 06 Dec 2018 13:27:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Sender:Content-Type:MIME-Version:
 Message-ID:Subject:To:From:Date:Reply-To:Cc:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jn/CCXwQtxMqcQMWvcjFa1IK5+rClfg5WihOjFeI+pI=; b=Qw0CprXM45llNRYuMgM0v89Y6
 OJ1+iViJ44a8vCoSdDoEDH4KZYVq+WQlkL1lVlBlYDDdM+ZjRqyBUXgBG50gYiZD+nZrXxZ5LlF7r
 QFJcqknUXvHJLryG7obBzedvUVs1/M5vtPRAOvFaDjAYT+8WXFCii/sq0GUdHXtv9RUD6Id0pSrCn
 GrpjFFlUS6faUk7UjQkDC7Ek8jsoIuzZvZhbmnFvfofbVZeucNEm4TOlM0Eqchd4t09tvg/en/RrI
 rh8ai8vBeZfobBUJikUvYc6h7dlhXvbomc3VD+xaX1sSr6mcenGTqadGH9Tk/XRc7DjGfnp3yRykr
 MSWIf6hgw==;
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUtcg-0005jk-Jn
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 13:23:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2014; h=Sender:Content-Type:MIME-Version:
 Message-ID:Subject:To:From:Date:Reply-To:Cc:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jn/CCXwQtxMqcQMWvcjFa1IK5+rClfg5WihOjFeI+pI=; b=UrnMTssTc+OXJcmHTrhyb/omL
 jsjk0Df6bcnfyelJrR/Gpm9j/oknaIbCBGAXHvBynB6Op4C85du+tmLjFga2UTG0ns8kZ0T4j55gp
 yxAX/bSnOQyUj9mi5G+7GrikTG3ZFryodIDg3KxYJ99Tmt5r5pPRp/TlYZBRQj4MS2X0M=;
Received: from n2100.armlinux.org.uk
 ([fd8f:7570:feb6:1:214:fdff:fe10:4f86]:39644)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 (envelope-from <linux@armlinux.org.uk>)
 id 1gUtcO-0001qV-Uu; Thu, 06 Dec 2018 13:23:05 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
 (envelope-from <linux@n2100.armlinux.org.uk>)
 id 1gUtcH-0002Ji-Vw; Thu, 06 Dec 2018 13:22:58 +0000
Date: Thu, 6 Dec 2018 13:22:56 +0000
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
 netdev@vger.kernel.org, Tony Lindgren <tony@atomide.com>
Subject: OMAP4430 SDP with KS8851: very slow networking
Message-ID: <20181206132256.GT30658@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_132322_711664_D20498FB 
X-CRM114-Status: GOOD (  12.31  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

I'm experiencing very slow networking on my OMAP4430 SDP board, which
uses the SPI ethernet chip KS8851.

The initial symptom I noticed is that tftping the 3MB kernel image
inside Linux takes more than 5 minutes.  Running tcpdump on the tftp
server shows:

13:13:29.018377 IP 192.168.1.189.45542 > 192.168.0.4.40620: UDP, length 4
13:13:29.020683 IP 192.168.1.189.45542 > 192.168.0.4.40620: UDP, length 4
13:13:29.022280 IP 192.168.0.4.40620 > 192.168.1.189.45542: UDP, length 516
13:13:29.078391 IP 192.168.1.189.45542 > 192.168.0.4.40620: UDP, length 4
13:13:29.080696 IP 192.168.1.189.45542 > 192.168.0.4.40620: UDP, length 4
13:13:29.082291 IP 192.168.0.4.40620 > 192.168.1.189.45542: UDP, length 516
13:13:29.138377 IP 192.168.1.189.45542 > 192.168.0.4.40620: UDP, length 4
13:13:29.140563 IP 192.168.1.189.45542 > 192.168.0.4.40620: UDP, length 4
13:13:29.142205 IP 192.168.0.4.40620 > 192.168.1.189.45542: UDP, length 516
13:13:29.198365 IP 192.168.1.189.45542 > 192.168.0.4.40620: UDP, length 4
13:13:29.200709 IP 192.168.1.189.45542 > 192.168.0.4.40620: UDP, length 4
13:13:29.202292 IP 192.168.0.4.40620 > 192.168.1.189.45542: UDP, length 516
13:13:29.258375 IP 192.168.1.189.45542 > 192.168.0.4.40620: UDP, length 4
13:13:29.260708 IP 192.168.1.189.45542 > 192.168.0.4.40620: UDP, length 4
13:13:29.262292 IP 192.168.0.4.40620 > 192.168.1.189.45542: UDP, length 516

which is about 512 bytes every 60ms.  The two length 4 UDPs are the
ACK packets - one of which is a repeated transmission for each
packet.

I also see NFS timing out.

pings also have weirdness:

root@omap-4430sdp:~# ping -c 10 192.168.0.4
PING 192.168.0.4 (192.168.0.4): 56 data bytes
64 bytes from 192.168.0.4: seq=0 ttl=64 time=107.635 ms
64 bytes from 192.168.0.4: seq=1 ttl=64 time=1011.689 ms
64 bytes from 192.168.0.4: seq=2 ttl=64 time=5.157 ms
64 bytes from 192.168.0.4: seq=3 ttl=64 time=1021.820 ms
64 bytes from 192.168.0.4: seq=4 ttl=64 time=4.395 ms
64 bytes from 192.168.0.4: seq=5 ttl=64 time=4.669 ms
64 bytes from 192.168.0.4: seq=6 ttl=64 time=371.735 ms
64 bytes from 192.168.0.4: seq=7 ttl=64 time=882.598 ms
64 bytes from 192.168.0.4: seq=8 ttl=64 time=31.372 ms
64 bytes from 192.168.0.4: seq=9 ttl=64 time=2010.772 ms

--- 192.168.0.4 ping statistics ---
10 packets transmitted, 10 packets received, 0% packet loss
round-trip min/avg/max = 4.395/545.184/2010.772 ms

If I ping the board remotely:

$ ping -i .2 192.168.1.189
PING 192.168.1.189 (192.168.1.189) 56(84) bytes of data.
64 bytes from 192.168.1.189: icmp_req=1 ttl=64 time=2033 ms
64 bytes from 192.168.1.189: icmp_req=2 ttl=64 time=1825 ms
64 bytes from 192.168.1.189: icmp_req=3 ttl=64 time=1616 ms
64 bytes from 192.168.1.189: icmp_req=4 ttl=64 time=1417 ms
64 bytes from 192.168.1.189: icmp_req=5 ttl=64 time=1218 ms
64 bytes from 192.168.1.189: icmp_req=6 ttl=64 time=1018 ms
64 bytes from 192.168.1.189: icmp_req=7 ttl=64 time=819 ms
64 bytes from 192.168.1.189: icmp_req=8 ttl=64 time=610 ms
64 bytes from 192.168.1.189: icmp_req=9 ttl=64 time=411 ms
64 bytes from 192.168.1.189: icmp_req=10 ttl=64 time=202 ms
64 bytes from 192.168.1.189: icmp_req=11 ttl=64 time=4.46 ms
64 bytes from 192.168.1.189: icmp_req=12 ttl=64 time=263 ms
64 bytes from 192.168.1.189: icmp_req=13 ttl=64 time=54.5 ms
64 bytes from 192.168.1.189: icmp_req=14 ttl=64 time=1399 ms
64 bytes from 192.168.1.189: icmp_req=15 ttl=64 time=1199 ms
64 bytes from 192.168.1.189: icmp_req=16 ttl=64 time=990 ms
64 bytes from 192.168.1.189: icmp_req=17 ttl=64 time=781 ms
64 bytes from 192.168.1.189: icmp_req=18 ttl=64 time=572 ms
64 bytes from 192.168.1.189: icmp_req=19 ttl=64 time=372 ms
64 bytes from 192.168.1.189: icmp_req=20 ttl=64 time=163 ms
^C
--- 192.168.1.189 ping statistics ---
22 packets transmitted, 20 received, 9% packet loss, time 4302ms
rtt min/avg/max/mdev = 4.468/848.854/2033.873/592.100 ms, pipe 10

It looks very much like a receive problem - in that the board is not
always aware of a packet having been received until it attempts to
transmit (eg, in the case of TFTP, when it re-sends the ACK after a
receive timeout, it _then_ notices that there's a packet waiting.)

I'm not quite sure when this cropped up as I no longer regularly
update and run my nightly boot tests, but I think 4.18 was fine.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
