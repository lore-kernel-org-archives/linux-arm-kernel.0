From: baruch@tkos.co.il (Baruch Siach)
Date: Thu, 27 Jul 2017 21:27:43 +0300
Subject: halting the kernel does not stop the CPU cores?
In-Reply-To: <VI1PR04MB1662099750F9EAFA0324C6538CBE0@VI1PR04MB1662.eurprd04.prod.outlook.com>
References: <VI1PR04MB1662099750F9EAFA0324C6538CBE0@VI1PR04MB1662.eurprd04.prod.outlook.com>
Message-ID: <20170727182743.ma4bo54mar4bknap@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heinz,

On Thu, Jul 27, 2017 at 02:38:48PM +0000, Heinz Wrobel wrote:
> I noticed that when halting the kernel (intentionally or not), the cores 
> effectively go into a while(1) loop and power consumption on larger devices 
> really jumps up significantly to the point where, e.g., a ?crash? turns into 
> ?crash and burn?.
> 
> I would assume that if a system is halted, you don?t want to dissipate more 
> power than on a running system but go as silent as low power as reasonable.
> 
> Is there any specific reason why the cores would not go into a wfi loop like 
> they do on idle?
> The patch to fix this seems to be easy at first glance, but is there a good 
> reason *NOT* to do such a patch and to leave the plain while(1)?

See https://patchwork.kernel.org/patch/9866711/ .

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
