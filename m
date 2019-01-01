Return-Path: <SRS0=AJAW=PJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E170C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 10:02:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE7F121871
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 10:02:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IMhR5Oml"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE7F121871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eircom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:References:Message-Id:Date:
	In-Reply-To:From:Subject:Mime-Version:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XLf8O6gx13/KTW8EEajMhhlr9aJ/2aaM5e+pXNYF1xE=; b=IMhR5Oml/KHtZA
	uHWzZCWpnasPzX7ksHWWCbXPmgTY2zYHrDs+XvP9OeROByJT4cy3QhAlNySw0bnHb7hQQLk8GYmWp
	QIJog2TSB8XwZLX7T0SGb3YPYRDNVmONa7IhSNweVY7sJTrJ94MsKLpzFiBKtHbZO7xj+glG8yW+7
	pAPhlCitrZfqZshlDnxVlOVFNLt2kpOSqGzAKmfe8TMIVF2DNObj0+Du8XVSTw0uKgn5gDS/mCOPX
	GZN2Ephx3n7lXQQYcp7w97w0lECs76XC6/QHus2KEPj/UAkQuZF6gYsgRnKKq7T6SLBwQfbxdQTYk
	gmMWLWrs4aEzJqrM6j4A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1geGsn-0004wD-J1; Tue, 01 Jan 2019 10:02:45 +0000
Received: from vie01a-dmta-pe06-1.mx.upcmail.net ([84.116.36.14])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1geGsk-0004ur-Ev
 for linux-arm-kernel@lists.infradead.org; Tue, 01 Jan 2019 10:02:44 +0000
Received: from [172.31.216.235] (helo=vie01a-pemc-psmtp-pe12.mail.upcmail.net)
 by vie01a-dmta-pe06.mx.upcmail.net with esmtp (Exim 4.88)
 (envelope-from <mikebrady@eircom.net>) id 1geGsd-0006ZR-G1
 for linux-arm-kernel@lists.infradead.org; Tue, 01 Jan 2019 11:02:35 +0100
Received: from helix.aillwee.com ([37.228.204.209])
 by vie01a-pemc-psmtp-pe12.mail.upcmail.net with ESMTP
 id eGscgwsRM2WSseGscg6Phy; Tue, 01 Jan 2019 11:02:35 +0100
X-Env-Mailfrom: mikebrady@eircom.net
X-Env-Rcptto: linux-arm-kernel@lists.infradead.org
X-SourceIP: 37.228.204.209
X-CNFS-Analysis: v=2.3 cv=E7kcWpVl c=1 sm=1 tr=0
 a=/+iDkf0alGTUGXENEoGzTg==:117 a=/+iDkf0alGTUGXENEoGzTg==:17
 a=kj9zAlcOel0A:10 a=3JhidrIBZZsA:10 a=ubFUiyxaF30C6IaYVzkA:9
 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19 a=CjuIK1q_8ugA:10
Received: from [172.20.10.9] (unknown [77.75.241.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by helix.aillwee.com (Postfix) with ESMTPSA id EE2CE4E607;
 Tue,  1 Jan 2019 10:02:32 +0000 (GMT)
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Subject: Re: [PATCH v2] ARM: staging: bcm2835-audio: interpolate audio delay
From: Mike Brady <mikebrady@eircom.net>
In-Reply-To: <s5h7ehgdiqq.wl-tiwai@suse.de>
Date: Tue, 1 Jan 2019 10:02:30 +0000
Message-Id: <2BEB4E93-1280-47BE-906F-106D5FFCF5F0@eircom.net>
References: <B1CDD261-AB22-43CE-AF46-DFB5460B5D50@eircom.net>
 <s5h7ehgdiqq.wl-tiwai@suse.de>
To: Takashi Iwai <tiwai@suse.de>
X-Mailer: Apple Mail (2.3445.100.39)
X-CMAE-Envelope: MS4wfIToomtEvi+MuvMey9z51sCn7WUB1OeIWeRcR1PZkh8xSLAPVeJozkIXmcBYYjcaYG7nMSE9V0pFB3qPmQQ84MCqJm6kfRK29QiyCg4MQf98n9sRPdyi
 XSBt7XSoqtlaadHx3295lwzNrwpaNn6MITqpx/Voz7eYF/EmSe+BDWvhSwK/qE97FTYJKbAe+S5TXxQf8i3Ck0ezPYRgiXDdZot1zRDhZhqaW7qzpfkTBpTs
 lcZyGoX1FDG1IAvEknhBxDEkJ52R6fF1ZCZfT0bHfqi9dcC9GkUzolBtWGjiDv0F3BPijzagdvQoLyhxy4hbp0zHkNElieR3+letBYB53HepBjzpQd0ClEvi
 7ro6HYlmySDrSoa5sChVEJKnvCCIqVyr7EKkt4KMf86/imHjSYbnP0aYYPRXf03wVtmifAMhCEgoXRwFYEdQpvSd4F8NX8zBjuNB+OwKbN7ikniMbXUQlRoa
 ttXgQpNBa2NHoqvhVK8sC3GfqeyLcnszq3EYHC0lkqKiLOru/fIXabM/wHft4BmBvxsY6oBA9WlGUbHSJyol5eU/cV7XxkNhm8Yhyy/KOe7kU9MIM3whTmf3
 R/YSq323YJH9kkLlHB8HmB72JQ6cn9JmASovDUk1cpH8e+8FT3uMMjzJieOLsA7x2J0=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190101_020242_503375_DF0870DD 
X-CRM114-Status: GOOD (  22.67  )
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
Cc: Stefan Wahren <stefan.wahren@i2se.com>, devel@driverdev.osuosl.org,
 alsa-devel@alsa-project.org, f.fainelli@gmail.com, julia.lawall@lip6.fr,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 Eric Anholt <eric@anholt.net>, linux-rpi-kernel@lists.infradead.org,
 nishka.dasgupta_ug18@ashoka.edu.in,
 Kirill Marinushkin <k.marinushkin@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Apologies for the delay coming back to this.

Having had a long look at the further implications of this proposed change, I would like to withdraw the suggested patch.

I agree that is would seem excessive to have to change the PCM core to accommodate it. Furthermore, the idea only works if is is legitimate to assume that frames are smoothly consumed in the interpolation interval. If that assumption were not to hold for some reason, then the delay reported would be wrong.

Thanks to everyone for their comments and inputs.

Regards
Mike



> On 13 Nov 2018, at 16:50, Takashi Iwai <tiwai@suse.de> wrote:
> 
> On Sun, 11 Nov 2018 19:21:29 +0100,
> Mike Brady wrote:
>> 
>> /* hardware definition */
>> static const struct snd_pcm_hardware snd_bcm2835_playback_hw = {
>> 	.info = (SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_BLOCK_TRANSFER |
>> 		 SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID |
>> -		 SNDRV_PCM_INFO_DRAIN_TRIGGER | SNDRV_PCM_INFO_SYNC_APPLPTR),
>> +		 SNDRV_PCM_INFO_BATCH | SNDRV_PCM_INFO_DRAIN_TRIGGER |
>> +		 SNDRV_PCM_INFO_SYNC_APPLPTR),
> 
> As already mentioned, the addition of SNDRV_PCM_INFO_BATCH should be
> irrelevant with this change.  Please create another patch to add this
> and clarify it in the changelog.
> 
>> diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
>> index 4e6110d778bd..574df7d7a1fa 100644
>> --- a/sound/core/pcm_lib.c
>> +++ b/sound/core/pcm_lib.c
>> @@ -229,19 +229,38 @@ static void update_audio_tstamp(struct snd_pcm_substream *substream,
>> 		(runtime->audio_tstamp_report.actual_type ==
>> 			SNDRV_PCM_AUDIO_TSTAMP_TYPE_DEFAULT)) {
>> 
>> -		/*
>> -		 * provide audio timestamp derived from pointer position
>> -		 * add delay only if requested
>> -		 */
>> +		// provide audio timestamp derived from pointer position
>> 
>> 		audio_frames = runtime->hw_ptr_wrap + runtime->status->hw_ptr;
>> 
>> -		if (runtime->audio_tstamp_config.report_delay) {
>> +		/*
>> +		 * If the runtime->delay is greater than zero, it's a
>> +		 * genuine delay, e.g. a delay due to a hardware fifo.
>> +		 *
>> +		 * But if the runtime->delay is less than zero, it's an
>> +		 * interpolated estimate of the number of frames output
>> +		 * since the hardware pointer was last updated.
>> +		 *
>> +		 * It would be calculated in the pointer callback.
>> +		 * For example, for the bcm_2835 driver, it is calculated in
>> +		 * snd_bcm2835_pcm_pointer().
>> +		 */
>> +
>> +		if (runtime->delay < 0) {
>> +			// The delay is an interpolated estimate...
>> 			if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
>> -				audio_frames -=  runtime->delay;
>> -			else
>> -				audio_frames +=  runtime->delay;
>> +				audio_frames += runtime->delay;
>> +		} else {
>> +			// The delay is a real delay. Add it if requested.
>> +			if (runtime->audio_tstamp_config.report_delay) {
>> +				if (substream->stream ==
>> +				    SNDRV_PCM_STREAM_PLAYBACK)
>> +					audio_frames -=  runtime->delay;
>> +				else
>> +					audio_frames +=  runtime->delay;
>> +			}
>> 		}
> 
> Well, honestly speaking, I'm really not fond of changing the PCM core
> just for this.
> 
> Can we make bcm audio driver providing the finer pointer update
> instead?  If we have a module option to disable that behavior, it's an
> enough excuse in case anyone really cares about the accuracy.
> 
> 
> thanks,
> 
> Takashi


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
