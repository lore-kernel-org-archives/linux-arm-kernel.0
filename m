From: julian.calaby@gmail.com (Julian Calaby)
Date: Mon, 11 Jan 2016 09:13:39 +1100
Subject: [PATCH v3 3/3] checkpatch: add virt barriers
In-Reply-To: <1452454200-8844-4-git-send-email-mst@redhat.com>
References: <1452454200-8844-1-git-send-email-mst@redhat.com>
 <1452454200-8844-4-git-send-email-mst@redhat.com>
Message-ID: <CAGRGNgXQANbKD=VA0Qx4Wp1+MpZUVV7by8RrKxF9o=qu=vUQqA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Michael,

On Mon, Jan 11, 2016 at 6:31 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
> Add virt_ barriers to list of barriers to check for
> presence of a comment.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  scripts/checkpatch.pl | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 15cfca4..4466579 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -5133,7 +5133,8 @@ sub process {
>                 }x;
>                 my $all_barriers = qr{
>                         $barriers|
> -                       smp_(?:$smp_barrier_stems)
> +                       smp_(?:$smp_barrier_stems)|
> +                       virt_(?:$smp_barrier_stems)

Sorry I'm late to the party here, but would it make sense to write this as:

(?:smp|virt)_(?:$smp_barrier_stems)

Thanks,

-- 
Julian Calaby

Email: julian.calaby at gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
