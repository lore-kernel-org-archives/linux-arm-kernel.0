From: robdclark@gmail.com (Rob Clark)
Date: Thu, 5 Mar 2015 21:28:12 -0500
Subject: [PATCH v2 1/3] devicetree: bindings: Document qcom,
 msm-id and qcom, board-id
In-Reply-To: <CAOesGMgy3VY=4-t+N0BYqCuSLQkh-rYe8nd9iJh1mMeBFz_sWQ@mail.gmail.com>
References: <1425503602-24916-1-git-send-email-galak@codeaurora.org>
 <7h8ufbjkod.fsf@deeprootsystems.com>
 <07D4E4D1-BF8C-4583-9505-9F321DB10406@codeaurora.org>
 <CAOesGMgy3VY=4-t+N0BYqCuSLQkh-rYe8nd9iJh1mMeBFz_sWQ@mail.gmail.com>
Message-ID: <CAF6AEGssMoo6c3nf_7fcATwocuETGZ8nbpGQpUO=KcKWC+rvHw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 5, 2015 at 8:59 PM, Olof Johansson <olof@lixom.net> wrote:
> On Thu, Mar 5, 2015 at 12:23 PM, Kumar Gala <galak@codeaurora.org> wrote:
>>
>> On Mar 5, 2015, at 1:42 PM, Kevin Hilman <khilman@kernel.org> wrote:
>>
>>> Kumar Gala <galak@codeaurora.org> writes:
>>>
>>>> The top level qcom,msm-id and qcom,board-id are utilized by bootloaders
>>>> on Qualcomm MSM platforms to determine which device tree should be
>>>> utilized and passed to the kernel.
>>>>
>>>> Cc: <devicetree@vger.kernel.org>
>>>> Signed-off-by: Kumar Gala <galak@codeaurora.org>
>>>
>>> Is this the special magic that allows qcom bootloaders to take a kernel
>>> plus multiple DTBs and figure out which DTB to pass?
>>>
>>> Kevin
>>
>> yes
>
> That's a bummer.
>
> Luckily, the solution for upstream is still quite simple: Provide only
> one devicetree, and it'll be used, right?
>

I never managed to figure out how to get that to work (at least on my
apq8074 dragonboard.. fortunately ifc6540 seems to work w/ appended
dtb).. kind of a pita because it is a bit of a non-standard boot.img
format too..

Otoh getting an upstream (or even different kernel) kernel working can
be hard enough as-is on random different tablet/phone/etc.  Why not
make whoever tries' life a bit easier by allowing some nonsense node
into the qcom dtbs which makes it compatible w/ bootloaders already
out there in the field ;-)

BR,
-R

>
> -Olof
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
