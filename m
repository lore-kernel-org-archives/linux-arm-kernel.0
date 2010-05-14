From: felipe.contreras@gmail.com (Felipe Contreras)
Date: Sat, 15 May 2010 01:24:15 +0300
Subject: [PATCH v2 08/17] omap: mailbox: only compile for configured archs
In-Reply-To: <8F7AF80515AF0D4D93307E594F3CB40E4BBC5C8A@dlee03.ent.ti.com>
References: <1273849310-32169-1-git-send-email-felipe.contreras@gmail.com>
	<1273849310-32169-9-git-send-email-felipe.contreras@gmail.com>
	<8F7AF80515AF0D4D93307E594F3CB40E4BBC5C8A@dlee03.ent.ti.com>
Message-ID: <AANLkTilPh72HNFBx5ZkOVOFUf0tiR8CL7-7Abjgxbx0G@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 15, 2010 at 12:27 AM, Kanigeri, Hari <h-kanigeri2@ti.com> wrote:
>>
>> - ? ? if (cpu_is_omap3430()) {
>> + ? ? if (false);
>
> -- Is this statement needed ?

Yeah, so:

if (false);
#if 0
else if (foo) {
}
#endif
else {
  return -1;
}

Works.

-- 
Felipe Contreras
