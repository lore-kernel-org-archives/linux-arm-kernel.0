Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC98C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:20:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AF3020836
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:20:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HaW/p2Jc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AF3020836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=/kart/DTNBR31nYIEbm9wUFDRq9JThX827FGTcaQBsY=; b=HaW/p2Jc8LIYs0JzrP3SgQznH
	u6TMdFULjqtyaRDDORTf3jQmgzyJoP5jLZR3rZQdIGwNzsbCTKbh5i5w1U7tI9tmfOs1G6kiBP/B3
	GIbzQQ6g5bWMq7goq0QBQizh0jVb4Oe6+f74thy7qk2W2TzESSkPQjiyPqsa7JGDbO1G4nMrGhiIo
	Ia5GOwoBfNYr5qQB01QOpN33Ka4aJlXPQvm4OJpStP8FbbcHCaxsLQvWi9qVtoO5GkNGihrCIr7Cb
	eu4cmKajIBFxPhEWGEQUcgJGXhqTgHHAJFCSf2Z5R9WtA9v39qJ6tdpcKQQNwWSLv38KV/zaQ4/kz
	kaRdvi5SQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwr5Y-0001ka-Jf; Thu, 21 Feb 2019 16:20:44 +0000
Received: from mail-pf1-f193.google.com ([209.85.210.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwr5U-0001j3-5U
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 16:20:42 +0000
Received: by mail-pf1-f193.google.com with SMTP id n74so14050967pfi.9
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 21 Feb 2019 08:20:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/++Cz1Zs6WAJeIapQqDg6Se45Vcqo3gD6KlzknmAVHk=;
 b=Iw45P2b2Djg4U9MC+SJB51GertngCQJv6y26Aasv8i6bxIe9xZAe+XinvDzBlTu3lN
 H7KmWFhma9EIFXMzoRY/Zw9c/f5UoUScaD2AG9B4idP77fIxIwD0qhuUEWy2Uk4h75fM
 zs8JYf1x3YBm1XzfEYeUU+ThJWC4Rc5ZcdxK2S0djs3PZeeeAYZ7qd75fbRt8mhXhxWw
 CSTFXbM4QNx+JeRgK/6NVqSXmhOCR+Dw6qY6Rczs4YtJZHcLquY8FiGqVQ64DH4yIwcY
 k+AgtiqwiXKXtutMPTOBWdkd7k98T7Ss/1vugqMbkp9ugvxh7liFw62NlrekSo6VsnUQ
 kKsA==
X-Gm-Message-State: AHQUAuYjeTfqrSSGYfgl5/0+ZFGU5DGyg/D4eqUu7trejURbmqgeSI4G
 TchzS/LFtJa5x+KXDPF147GCCB9jxNs=
X-Google-Smtp-Source: AHgI3IYeDKO1imYjOgpaha+0B5KYU1ZizsqzlOd4q5jYzqb1HBi1uP6YZoIIz3xZQHEJHi5HVUMcig==
X-Received: by 2002:a63:54c:: with SMTP id 73mr7289676pgf.295.1550766039007;
 Thu, 21 Feb 2019 08:20:39 -0800 (PST)
Received: from localhost.localdomain ([182.69.202.151])
 by smtp.gmail.com with ESMTPSA id 63sm16192391pfs.65.2019.02.21.08.20.33
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 21 Feb 2019 08:20:38 -0800 (PST)
Subject: Re: [PATCH] arm64, vmcoreinfo : Append 'MAX_USER_VA_BITS' and
 'MAX_PHYSMEM_BITS' to vmcoreinfo
To: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
References: <1548850991-11879-1-git-send-email-bhsharma@redhat.com>
 <20190131014800.GB15785@dhcp-128-65.nay.redhat.com>
 <4AE2DC15AC0B8543882A74EA0D43DBEC03567AA3@BPXM09GP.gisp.nec.co.jp>
 <d7d50b5a-3577-448e-d928-7898016a38fb@redhat.com>
 <20190212104407.GA17022@dhcp-128-65.nay.redhat.com>
 <CACi5LpOAADU8s+3e6=fO7FT+VtAmWYNeZN9COF+4Gt6twLWYaA@mail.gmail.com>
 <4AE2DC15AC0B8543882A74EA0D43DBEC035683DB@BPXM09GP.gisp.nec.co.jp>
 <20190213111552.GA8265@dhcp-128-65.nay.redhat.com>
 <bed51e6e-3dcb-8e07-1d31-9d81bfca20e5@arm.com>
 <4AE2DC15AC0B8543882A74EA0D43DBEC03568504@BPXM09GP.gisp.nec.co.jp>
 <37ed4c14-e4b9-49c0-4816-c289ce65fd76@arm.com>
 <CACi5LpN6gVy4gCTYLGRiWW1VNGrVc-+Ykn919LKsO2bP-v1NHw@mail.gmail.com>
 <4AE2DC15AC0B8543882A74EA0D43DBEC03568A9F@BPXM09GP.gisp.nec.co.jp>
From: Bhupesh Sharma <bhsharma@redhat.com>
Message-ID: <891eaf5a-aede-364d-6465-832e377c3e29@redhat.com>
Date: Thu, 21 Feb 2019 21:50:30 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <4AE2DC15AC0B8543882A74EA0D43DBEC03568A9F@BPXM09GP.gisp.nec.co.jp>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_082040_201182_9E61168E 
X-CRM114-Status: GOOD (  20.25  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 "lijiang@redhat.com" <lijiang@redhat.com>, "bhe@redhat.com" <bhe@redhat.com>,
 "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 Steve Capper <Steve.Capper@arm.com>,
 "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
 Will Deacon <will.deacon@arm.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 James Morse <james.morse@arm.com>,
 Kristina Martsenko <kristina.martsenko@arm.com>,
 Borislav Petkov <bp@alien8.de>, "anderson@redhat.com" <anderson@redhat.com>,
 Dave Young <dyoung@redhat.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Kazu,

On 02/20/2019 02:17 AM, Kazuhito Hagio wrote:
> Hi Bhupesh,
> 
> -----Original Message-----
>> I am not sure you got a chance to look at the two regression cases I
>> reported here:
>> <http://lists.infradead.org/pipermail/kexec/2019-February/022449.html>
>>
>> Unfortunately the above suggestion doesn't provide any fix for
>> ARMv8.2-LPA regression (see text under heading '
>> (1). Regression Case 1 (ARMv8.2-LPA enabled kernel)')
> 
> As for MAX_PHYSMEM_BITS, I realized that ppc64 makedumpfile can detect
> it because there is only one SECTION_SIZE_BITS for ppc64. I think we
> can use the same way as set_ppc64_max_physmem_bits() does also for
> arm64 for now. I'm going to write it for kernels not having
> NUMBER(MAX_PHYSMEM_BITS) in vmcoreinfo.

I see two drawbacks with the above approach:

a). This means that other user-space tools like crash-utility would 
still be broken and would probably need to find MAX_PHYSMEM_BITS for 
arm64 via a similar (hack'ish ?) approach.

b). I am looking at the makedumpfile code for 'MAX_PHYSMEM_BITS' 
determination for two archs as an example:

ppc
---

int
set_ppc64_max_physmem_bits(void)
{
         long array_len = ARRAY_LENGTH(mem_section);
         /*
          * The older ppc64 kernels uses _MAX_PHYSMEM_BITS as 42 and the
          * newer kernels 3.7 onwards uses 46 bits.
          */

         info->max_physmem_bits  = _MAX_PHYSMEM_BITS_ORIG ;
         if ((array_len == (NR_MEM_SECTIONS() / 
_SECTIONS_PER_ROOT_EXTREME()))
                 || (array_len == (NR_MEM_SECTIONS() / 
_SECTIONS_PER_ROOT())))
                 return TRUE;

         info->max_physmem_bits  = _MAX_PHYSMEM_BITS_3_7;
         if ((array_len == (NR_MEM_SECTIONS() / 
_SECTIONS_PER_ROOT_EXTREME()))
                 || (array_len == (NR_MEM_SECTIONS() / 
_SECTIONS_PER_ROOT())))
                 return TRUE;

         info->max_physmem_bits  = _MAX_PHYSMEM_BITS_4_19;
         if ((array_len == (NR_MEM_SECTIONS() / 
_SECTIONS_PER_ROOT_EXTREME()))
                 || (array_len == (NR_MEM_SECTIONS() / 
_SECTIONS_PER_ROOT())))
                 return TRUE;

         info->max_physmem_bits  = _MAX_PHYSMEM_BITS_4_20;
         if ((array_len == (NR_MEM_SECTIONS() / 
_SECTIONS_PER_ROOT_EXTREME()))
                 || (array_len == (NR_MEM_SECTIONS() / 
_SECTIONS_PER_ROOT())))
                 return TRUE;

         return FALSE;
}

x86_64:
------

int
get_versiondep_info_x86_64(void)
{
     /*
      * On linux-2.6.26, MAX_PHYSMEM_BITS is changed to 44 from 40.
      */
     if (info->kernel_version < KERNEL_VERSION(2, 6, 26))
         info->max_physmem_bits  = _MAX_PHYSMEM_BITS_ORIG;
     else if (info->kernel_version < KERNEL_VERSION(2, 6, 31))
         info->max_physmem_bits  = _MAX_PHYSMEM_BITS_2_6_26;
     else if(check_5level_paging())
         info->max_physmem_bits  = _MAX_PHYSMEM_BITS_5LEVEL;
     else
         info->max_physmem_bits  = _MAX_PHYSMEM_BITS_2_6_31;

     ...
}

Looking at the above, two questions come to my mind:

- Do we really need all the above complexity in user-space code, to hoop 
across various kernel versions and perform allocations for something 
that can be so easily exported via vmcoreinfo? Also we need to see how 
portable is the above code for a new kernel version - IMO, it will need 
another fix patch when we update to a new kernel version in near future.

- Also do we need to replicate the above implementations across 
user-space tools when they can also utilize the vmcoreinfo information 
to determine the PA_BITS range without any additional arch/kernel 
version specific details as the single point of obtaining this 
information from the kernel?

So, in view of the above, I would still advocate that we use a 
vmcoreinfo export for 'MAX_PHYSMEM_BITS' as well to have a uniform 
interface for the same across all user-land applications.

Thanks,
Bhupesh


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
