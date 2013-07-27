From: tim.kryger@linaro.org (Tim Kryger)
Date: Fri, 26 Jul 2013 17:13:46 -0700
Subject: [PATCH v3 2/3] ARM: bcm281xx: Device Tree bindings for GPIO driver
In-Reply-To: <CAPdLdqnq21zPNdJ_4iYS96yQH1XeuTp-TbwHpvkwsECHEKOKaQ@mail.gmail.com>
References: <1374870345-8276-1-git-send-email-markus.mayer@linaro.org>
 <1374870345-8276-3-git-send-email-markus.mayer@linaro.org>
 <51F2F37B.8030306@wwwdotorg.org>
 <CAPdLdqmU0aw5h_KYcD-E=isC9U3mZF6fzr_GVdjUUAW4_PUD5Q@mail.gmail.com>
 <51F301C4.4070807@wwwdotorg.org>
 <CAPdLdqnq21zPNdJ_4iYS96yQH1XeuTp-TbwHpvkwsECHEKOKaQ@mail.gmail.com>
Message-ID: <CAAYSxhrXg=dnhUzMuV=t=oQrnMQUWvLFydGEJD2pZV+EEPGLuA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 26, 2013 at 4:22 PM, Markus Mayer <markus.mayer@linaro.org> wrote:
> On 26 July 2013 16:09, Stephen Warren <swarren@wwwdotorg.org> wrote:
>> Isn't this a property of the SoC's IP block, not of the board?
>
> Yes. I wasn't very precise with my statement.
>
> What I added to the description is "Specify at least 1 GPIO interrupt.
> The maximum number is 6."

The IP has a configurable number of banks, each of which has its own
interrupt.  If a particular SoC was configured to have six banks then
you need to list six interrupts in the DTS.  Perhaps it would help to
spell that out that relationship explicitly in the documentation
rather than talking about a minimum or maximum number of interrupts?
Also, you may want to mention that interrupts should to be ordered by
bank number.
