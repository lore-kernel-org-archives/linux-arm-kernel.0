From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Fri, 4 Sep 2015 07:46:24 +0200
Subject: [PATCH v3 01/18] platform: delay OF device-driver matches until
 late_initcall
In-Reply-To: <20150810102515.GA1965@sirena.org.uk>
References: <1438870315-18689-1-git-send-email-tomeu.vizoso@collabora.com>
 <1438870315-18689-2-git-send-email-tomeu.vizoso@collabora.com>
 <CAL_Jsq+GLMZe-f6qEi=7i1YrrWc6k99RpGkOyCd5KkYDiyt0QA@mail.gmail.com>
 <CAAObsKBapFqzr+4YEXJfcJWMd+tkaBqYbGiFTntHStAP=+P-_Q@mail.gmail.com>
 <55C4E597.1010701@ti.com>
 <CAAObsKDJsuhuQfLbxq27Mtm1T_Auz7Gohp8PDyK7rNNDyaGhcg@mail.gmail.com>
 <20150810102515.GA1965@sirena.org.uk>
Message-ID: <CAAObsKB0XiqquxFxAnH5LzenrcY8SbH69qPW25m6R9B09DQT5g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 August 2015 at 12:25, Mark Brown <broonie@kernel.org> wrote:
> On Sun, Aug 09, 2015 at 03:03:14PM +0200, Tomeu Vizoso wrote:
>
>> There was some recent thread about how the disabling of unused clocks
>> and regulators isn't really safe because after late_initcall_sync more
>> drivers can be registered from modules. Furthermore, there's async
>> device probes.
>
> What recent thread and why would that be unsafe?

Sorry, I should have said instead that it's already unpredictable and
that from what I have seen during testing these series doesn't make it
any worst.

Regards,

Tomeu

> Any driver using a
> clock or regulator ought to be making sure that the clock or regulator
> is enabled before it tries to use it.  The worst that should happen is
> that something gets the power bounced during boot which isn't the end of
> the world.
