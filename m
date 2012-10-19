From: tony@atomide.com (Tony Lindgren)
Date: Fri, 19 Oct 2012 11:53:48 -0700
Subject: [PATCH 08/10] pinctrl: single: support pinconf generic
In-Reply-To: <CAN1soZzsruhWt7VFgf5Fi79npcjLiMSUEVwnE3hR5iWEh+9GRw@mail.gmail.com>
References: <1350551224-12857-1-git-send-email-haojian.zhuang@gmail.com>
 <1350551224-12857-8-git-send-email-haojian.zhuang@gmail.com>
 <CACRpkda0QLkdKns3CXNOijYBjaDtW1QyhNYjTqDvRH-in8pvZQ@mail.gmail.com>
 <20121018222907.GH30550@atomide.com>
 <CAN1soZzsruhWt7VFgf5Fi79npcjLiMSUEVwnE3hR5iWEh+9GRw@mail.gmail.com>
Message-ID: <20121019185348.GS4730@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Haojian Zhuang <haojian.zhuang@gmail.com> [121018 19:25]:
> 
> I wonder whether gpio function in OMAP is also configured in the pinmux
> register. For example, the function is 3bit field in pinmux register
> of Marvell's
> PXA/MMP silicon. GPIO function is the one of function.

For omaps, the mux registers in padconf area just control
the routing of the signal, pulls and wake-up events. So
gpio mode is a number in the mode bits [2:0]. It's mode 3
for some omaps and mode 4 for some omaps. All the other GPIO
related registers are elsewhere.

Sounds like this is different from what you are describing,
but if you want to compare it, the register bits in the
legacy mach-omap2/mux.h are:

/* 34xx mux mode options for each pin. See TRM for options */
#define OMAP_MUX_MODE0      0
#define OMAP_MUX_MODE1      1
#define OMAP_MUX_MODE2      2
#define OMAP_MUX_MODE3      3
#define OMAP_MUX_MODE4      4
#define OMAP_MUX_MODE5      5
#define OMAP_MUX_MODE6      6
#define OMAP_MUX_MODE7      7
               
/* 24xx/34xx mux bit defines */
#define OMAP_PULL_ENA                   (1 << 3)
#define OMAP_PULL_UP                    (1 << 4)
#define OMAP_ALTELECTRICALSEL           (1 << 5)
               
/* 34xx specific mux bit defines */
#define OMAP_INPUT_EN                   (1 << 8)
#define OMAP_OFF_EN                     (1 << 9)
#define OMAP_OFFOUT_EN                  (1 << 10)
#define OMAP_OFFOUT_VAL                 (1 << 11)
#define OMAP_OFF_PULL_EN                (1 << 12)
#define OMAP_OFF_PULL_UP                (1 << 13)
#define OMAP_WAKEUP_EN                  (1 << 14)
       
/* 44xx specific mux bit defines */
#define OMAP_WAKEUP_EVENT               (1 << 15)

Regards,

Tony
